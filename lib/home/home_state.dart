import 'package:flutter/foundation.dart';
import 'package:wow_armory/api/card_search_result.dart';
import 'package:wow_armory/thing.dart';

@immutable
class HomeState {
  HomeState.initial({this.cards = const [], this.focusedCard});
  HomeState.ofCards(this.cards, {this.focusedCard});

  final List<HSCard> cards;
  final FocusedCard focusedCard;
}

class FocusedCard {
  final HSCard card;
  final WidgetData position;

  FocusedCard(this.card, this.position);
}
