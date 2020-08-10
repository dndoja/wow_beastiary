import 'package:bloc/bloc.dart';
import 'package:wow_armory/api/blizzard_api_client.dart';
import 'package:wow_armory/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final BlizzardApiClient _apiClient;

  HomeCubit(this._apiClient) : super(HomeState.initial());

  void search(String query) {
    _apiClient
        .searchCreatures(creatureName: query)
        .then((value) => this.emit(HomeState.ofCreatures(value.results)));
  }
}
