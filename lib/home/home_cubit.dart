import 'package:bloc/bloc.dart';
import 'package:wow_armory/api/blizzard_api_client.dart';
import 'package:wow_armory/api/card_search_result.dart';
import 'package:wow_armory/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final BlizzardApiClient _apiClient;

  HomeCubit(this._apiClient) : super(HomeState.initial()) {
    search('');
  }

  void search(String query) async {
    final queryLower = query.toLowerCase();
    final searchResult = await _apiClient.searchCards(creatureName: query);
    this.emit(
        HomeState.ofCards(
            searchResult.cards
                .where((card) => card.text.isNotEmpty && (card.name.toLowerCase().contains(queryLower)))
                .toList()
        )
    );
  }

  void focusOnCard(FocusedCard card){
    emit(HomeState.ofCards(state.cards, focusedCard: card));
  }

  removeFocusFromCard() {
    emit(HomeState.ofCards(state.cards));
  }
}
