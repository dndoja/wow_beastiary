// To parse this JSON data, do
//
//     final cardSearchResult = cardSearchResultFromMap(jsonString);

import 'dart:convert';

class CardSearchResult {
  CardSearchResult({
    this.cards,
    this.cardCount,
    this.pageCount,
    this.page,
  });

  List<Card> cards;
  int cardCount;
  int pageCount;
  int page;

  factory CardSearchResult.fromJson(String str) =>
      CardSearchResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardSearchResult.fromMap(Map<String, dynamic> json) =>
      CardSearchResult(
        cards: List<Card>.from(json["cards"].map((x) => Card.fromMap(x))),
        cardCount: json["cardCount"],
        pageCount: json["pageCount"],
        page: json["page"],
      );

  Map<String, dynamic> toMap() => {
        "cards": List<dynamic>.from(cards.map((x) => x.toMap())),
        "cardCount": cardCount,
        "pageCount": pageCount,
        "page": page,
      };
}

class Card {
  Card({
    this.id,
    this.collectible,
    this.slug,
    this.classId,
    this.multiClassIds,
    this.cardTypeId,
    this.cardSetId,
    this.rarityId,
    this.artistName,
    this.health,
    this.manaCost,
    this.name,
    this.text,
    this.image,
    this.imageGold,
    this.flavorText,
    this.cropImage,
    this.parentId,
    this.childIds,
    this.minionTypeId,
    this.attack,
    this.keywordIds,
    this.durability,
  });

  int id;
  int collectible;
  String slug;
  int classId;
  List<int> multiClassIds;
  int cardTypeId;
  int cardSetId;
  int rarityId;
  String artistName;
  int health;
  int manaCost;
  String name;
  String text;
  String image;
  String imageGold;
  String flavorText;
  String cropImage;
  int parentId;
  List<int> childIds;
  int minionTypeId;
  int attack;
  List<int> keywordIds;
  int durability;

  factory Card.fromJson(String str) => Card.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Card.fromMap(Map<String, dynamic> json) => Card(
        id: json["id"],
        collectible: json["collectible"],
        slug: json["slug"],
        classId: json["classId"],
        multiClassIds: List<int>.from(json["multiClassIds"].map((x) => x)),
        cardTypeId: json["cardTypeId"],
        cardSetId: json["cardSetId"],
        rarityId: json["rarityId"],
        artistName: json["artistName"] == null ? null : json["artistName"],
        health: json["health"] == null ? null : json["health"],
        manaCost: json["manaCost"],
        name: json["name"],
        text: json["text"],
        image: json["image"],
        imageGold: json["imageGold"],
        flavorText: json["flavorText"],
        cropImage: json["cropImage"],
        parentId: json["parentId"] == null ? null : json["parentId"],
        childIds: json["childIds"] == null
            ? null
            : List<int>.from(json["childIds"].map((x) => x)),
        minionTypeId:
            json["minionTypeId"] == null ? null : json["minionTypeId"],
        attack: json["attack"] == null ? null : json["attack"],
        keywordIds: json["keywordIds"] == null
            ? null
            : List<int>.from(json["keywordIds"].map((x) => x)),
        durability: json["durability"] == null ? null : json["durability"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "collectible": collectible,
        "slug": slug,
        "classId": classId,
        "multiClassIds": List<dynamic>.from(multiClassIds.map((x) => x)),
        "cardTypeId": cardTypeId,
        "cardSetId": cardSetId,
        "rarityId": rarityId,
        "artistName": artistName == null ? null : artistName,
        "health": health == null ? null : health,
        "manaCost": manaCost,
        "name": name,
        "text": text,
        "image": image,
        "imageGold": imageGold,
        "flavorText": flavorText,
        "cropImage": cropImage,
        "parentId": parentId == null ? null : parentId,
        "childIds": childIds == null
            ? null
            : List<dynamic>.from(childIds.map((x) => x)),
        "minionTypeId": minionTypeId == null ? null : minionTypeId,
        "attack": attack == null ? null : attack,
        "keywordIds": keywordIds == null
            ? null
            : List<dynamic>.from(keywordIds.map((x) => x)),
        "durability": durability == null ? null : durability,
      };
}
