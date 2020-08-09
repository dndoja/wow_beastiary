import 'dart:convert';

CreatureSearchResult creatureSearchResultFromJson(Map<String, dynamic> json) => CreatureSearchResult.fromJson(json);

String creatureSearchResultToJson(CreatureSearchResult data) => json.encode(data.toJson());

class CreatureSearchResult {
  CreatureSearchResult({
    this.page,
    this.pageSize,
    this.maxPageSize,
    this.pageCount,
    this.results,
  });

  final int page;
  final int pageSize;
  final int maxPageSize;
  final int pageCount;
  final List<CreatureResult> results;

  factory CreatureSearchResult.fromJson(Map<String, dynamic> json) => CreatureSearchResult(
    page: json["page"],
    pageSize: json["pageSize"],
    maxPageSize: json["maxPageSize"],
    pageCount: json["pageCount"],
    results: List<CreatureResult>.from(json["results"].map((x) => CreatureResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "pageSize": pageSize,
    "maxPageSize": maxPageSize,
    "pageCount": pageCount,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class CreatureResult {
  CreatureResult({
    this.key,
    this.data,
  });

  final CreatureKey key;
  final CreatureData data;

  factory CreatureResult.fromJson(Map<String, dynamic> json) => CreatureResult(
    key: CreatureKey.fromJson(json["key"]),
    data: CreatureData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "key": key.toJson(),
    "data": data.toJson(),
  };
}

class CreatureData {
  CreatureData({
    this.creatureDisplays,
    this.isTameable,
    this.name,
    this.id,
    this.type,
    this.family,
  });

  final List<CreatureDisplay> creatureDisplays;
  final bool isTameable;
  final CreatureName name;
  final int id;
  final Type type;
  final Type family;

  factory CreatureData.fromJson(Map<String, dynamic> json) => CreatureData(
    creatureDisplays: List<CreatureDisplay>.from(json["creature_displays"].map((x) => CreatureDisplay.fromJson(x))),
    isTameable: json["is_tameable"],
    name: CreatureName.fromJson(json["name"]),
    id: json["id"],
    type: Type.fromJson(json["type"]),
    family: json["family"] == null ? null : Type.fromJson(json["family"]),
  );

  Map<String, dynamic> toJson() => {
    "creature_displays": List<dynamic>.from(creatureDisplays.map((x) => x.toJson())),
    "is_tameable": isTameable,
    "name": name.toJson(),
    "id": id,
    "type": type.toJson(),
    "family": family == null ? null : family.toJson(),
  };
}

class CreatureDisplay {
  CreatureDisplay({
    this.id,
  });

  final int id;

  factory CreatureDisplay.fromJson(Map<String, dynamic> json) => CreatureDisplay(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

class Type {
  Type({
    this.name,
    this.id,
  });

  final CreatureName name;
  final int id;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    name: CreatureName.fromJson(json["name"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name.toJson(),
    "id": id,
  };
}

class CreatureName {
  CreatureName({
    this.itIt,
    this.ruRu,
    this.enGb,
    this.zhTw,
    this.koKr,
    this.enUs,
    this.esMx,
    this.ptBr,
    this.esEs,
    this.zhCn,
    this.frFr,
    this.deDe,
  });

  final String itIt;
  final String ruRu;
  final String enGb;
  final String zhTw;
  final String koKr;
  final String enUs;
  final String esMx;
  final String ptBr;
  final String esEs;
  final String zhCn;
  final String frFr;
  final String deDe;

  factory CreatureName.fromJson(Map<String, dynamic> json) => CreatureName(
    itIt: json["it_IT"],
    ruRu: json["ru_RU"],
    enGb: json["en_GB"],
    zhTw: json["zh_TW"],
    koKr: json["ko_KR"],
    enUs: json["en_US"],
    esMx: json["es_MX"],
    ptBr: json["pt_BR"],
    esEs: json["es_ES"],
    zhCn: json["zh_CN"],
    frFr: json["fr_FR"],
    deDe: json["de_DE"],
  );

  Map<String, dynamic> toJson() => {
    "it_IT": itIt,
    "ru_RU": ruRu,
    "en_GB": enGb,
    "zh_TW": zhTw,
    "ko_KR": koKr,
    "en_US": enUs,
    "es_MX": esMx,
    "pt_BR": ptBr,
    "es_ES": esEs,
    "zh_CN": zhCn,
    "fr_FR": frFr,
    "de_DE": deDe,
  };
}

class CreatureKey {
  CreatureKey({
    this.href,
  });

  final String href;

  factory CreatureKey.fromJson(Map<String, dynamic> json) => CreatureKey(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}
