import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class SeasonsDto {
  final String uid;
  final String nome;
  final int number;
  final int? createdat;
  final int? updatedat;

  SeasonsDto({
    required this.uid,
    required this.nome,
    required this.number,
    this.createdat,
    this.updatedat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'nome': nome,
      'number': number,
      'createdat': createdat,
      'updatedat': updatedat,
    };
  }

  factory SeasonsDto.fromMap(Map<String, dynamic> map) {
    return SeasonsDto(
      uid: map['uid'],
      nome: map['nome'],
      number: map['number'],
      createdat: map['createdat'],
      updatedat: map['updatedat'],
    );
  }
  factory SeasonsDto.fromEntity(TemporadaModel entity) {
    return SeasonsDto(
      uid: entity.id!,
      nome: entity.nome,
      number: entity.number,
      createdat: entity.createdat,
      updatedat: entity.updatedat,
    );
  }

  TemporadaModel toEntity() {
    return TemporadaModel(
      createdat: createdat ?? 0,
      updatedat: updatedat ?? 0,
      nome: nome,
      number: number,
      id: uid,
    );
  }
}
