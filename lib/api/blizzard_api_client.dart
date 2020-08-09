import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:wow_armory/api/models/creature_search_result.dart';

class BlizzardAuthClient {
  final Dio _dio = Dio();
  static const _tokenEndpoint = "https://eu.battle.net/oauth/token";
  static const _identifier = "ab2699b134414f68a8f88a88d995c082";
  static const _secret = "s4Pzadt54z4D40MK6z9akUrtMrTZjrjX";
  var token = "";

  Future<String> _getAuthenticationToken() async {
    final formData = FormData.fromMap({
      "grant_type":"client_credentials",
      "client_id ": _identifier,
      "client_secret": _secret
    });

    final basicAuth = 'Basic ' + base64Encode(utf8.encode('$_identifier:$_secret'));
    final response = await _dio.post(_tokenEndpoint, data: formData, options: Options(headers: {"authorization":basicAuth}));

    return response.data["access_token"];
  }

  Future refreshAuthenticationToken() async {
    this.token = await _getAuthenticationToken();
  }
}

class BlizzardApiClient {
  final Dio _dio = Dio();
  final BlizzardAuthClient _authClient;

  static const region = "eu";
  static const namespace = "static-eu";
  static const baseUrl = "https://eu.api.blizzard.com";

  BlizzardApiClient(this._authClient){
    _addHeaderInterceptor();
    _addTokenRefreshingInterceptor();
  }

  void _addHeaderInterceptor(){
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      var customHeaders = {
        'Authorization': 'Bearer ${_authClient.token}'
      };
      options.headers.addAll(customHeaders);
      return options;
    }));
  }

  void _addTokenRefreshingInterceptor(){
    _dio.interceptors.add(InterceptorsWrapper(onError: (error) async {
      if(error.response?.statusCode==401){
        final request = error.response.request;
        final bearerToken = 'Bearer ${_authClient.token}';

        // If the token has been updated, repeat directly.
        if(bearerToken != request.headers["Authorization"]){
          request.headers["Authorization"] = bearerToken;
          return  _dio.request(request.path, options: request);
        }

        // update token and repeat
        // Lock to block the incoming request until the token updated
        _dio.interceptors.requestLock.lock();
        _dio.interceptors.responseLock.lock();

        return _authClient.refreshAuthenticationToken().whenComplete((){
          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
        }).then((e){
          //repeat
          return _dio.request(request.path, options: request);
        });
      }
      return error;
    }));
  }

  Future<CreatureSearchResult> searchCreatures({String creatureName = "", int page = 1}) async {
    final response = await _dio.get('$baseUrl/data/wow/search/creature', queryParameters: {
      "namespace": namespace,
      "locale": "en_US",
      "_page":page
    });

    return creatureSearchResultFromJson(response.data);
  }
}