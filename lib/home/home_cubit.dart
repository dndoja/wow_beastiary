import 'package:bloc/bloc.dart';
import 'package:wow_armory/api/blizzard_api_client.dart';
import 'package:wow_armory/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final BlizzardApiClient _apiClient;

  HomeCubit(this._apiClient) : super(HomeState.initial()) {
    search('');
  }

  void search(String query) {
    _apiClient
        .searchCards(creatureName: query)
        .then((value) => print("po kari po brravo"))
        .catchError((error) => print(error.toString()));
        //.then((value) => print(value.toJson()));
  }
}
