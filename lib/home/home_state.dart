import 'package:flutter/foundation.dart';
import 'package:wow_armory/api/models/creature_search_result.dart';

@immutable
class HomeState {
  HomeState.initial({this.creatures = const []});
  HomeState.ofCreatures(this.creatures);

  final List<CreatureResult> creatures;
}
