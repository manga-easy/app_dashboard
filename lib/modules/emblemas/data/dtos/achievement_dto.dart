import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class AchievementDto {
  String? uid;
  String name;
  String rarity;
  String description;
  double percent;
  String url;
  bool adsoff;
  String benefits;
  bool disponivel;
  String categoria;
  String type;
  int timecria;
  int? createdat;
  int? updatedat;
  AchievementDto({
    required this.uid,
    required this.name,
    required this.rarity,
    required this.description,
    required this.percent,
    required this.url,
    required this.adsoff,
    required this.benefits,
    required this.disponivel,
    required this.categoria,
    required this.type,
    required this.timecria,
    required this.createdat,
    required this.updatedat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'rarity': rarity,
      'description': description,
      'percent': percent,
      'url': url,
      'adsoff': adsoff,
      'benefits': benefits,
      'disponivel': disponivel,
      'categoria': categoria,
      'type': type,
      'timecria': timecria,
      'createdat': createdat,
      'updatedat': updatedat,
    };
  }

  factory AchievementDto.fromMap(Map<String, dynamic> map) {
    return AchievementDto(
      uid: map['uid'],
      name: map['name'],
      rarity: map['rarity'],
      description: map['description'],
      percent: map['percent'],
      url: map['url'],
      adsoff: map['adsoff'],
      benefits: map['benefits'],
      disponivel: map['disponivel'],
      categoria: map['categoria'],
      type: map['type'],
      timecria: map['timecria'],
      createdat: map['createdat'],
      updatedat: map['updatedat'],
    );
  }

  factory AchievementDto.fromEntity(Emblema entity) {
    return AchievementDto(
      uid: entity.id,
      name: entity.name,
      rarity: entity.rarity.name,
      description: entity.description,
      percent: entity.percent,
      url: entity.url,
      adsoff: entity.adsOff,
      benefits: entity.benefits.join(','),
      disponivel: entity.disponivel,
      categoria: entity.categoria,
      type: entity.type,
      timecria: entity.createAt,
      createdat: entity.createAt,
      updatedat: entity.updateAt,
    );
  }
  Emblema toEntity() {
    return Emblema(
      name: name,
      rarity: Emblema.validaRarity(rarity),
      description: description,
      percent: percent,
      url: url,
      benefits: Helps.convertStringToList(benefits),
      adsOff: adsoff,
      disponivel: disponivel,
      type: type,
      categoria: categoria,
      createAt: createdat ?? timecria,
      updateAt: updatedat ?? timecria,
    );
  }
}
