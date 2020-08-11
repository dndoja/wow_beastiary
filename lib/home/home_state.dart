import 'package:flutter/foundation.dart';
import 'package:wow_armory/api/card_search_result.dart';

@immutable
class HomeState {
  HomeState.initial({this.cards = const []});
  HomeState.ofCards(this.cards);

  final List<Card> cards;
}
