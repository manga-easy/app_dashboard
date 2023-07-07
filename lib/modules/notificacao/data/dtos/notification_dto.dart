import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class NotificationDto {
  final String? uid;
  final String titulo;
  final String menssege;
  final String image;
  final int datemade;
  final int? createdat;
  final int? updatedat;

  NotificationDto({
    this.uid,
    required this.titulo,
    required this.menssege,
    required this.image,
    required this.datemade,
    required this.createdat,
    required this.updatedat,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'titulo': titulo,
      'menssege': menssege,
      'image': image,
      'datemade': datemade,
      'createdat': createdat,
      'updatedat': updatedat,
    };
  }

  factory NotificationDto.fromMap(Map<String, dynamic> map) {
    return NotificationDto(
      uid: map['uid'],
      titulo: map['titulo'],
      menssege: map['menssege'],
      image: map['image'],
      datemade: map['datemade'],
      createdat: map['createdat'],
      updatedat: map['updatedat'],
    );
  }

  factory NotificationDto.fromEntity(Notificacao entity) {
    return NotificationDto(
      uid: entity.id,
      titulo: entity.titulo,
      menssege: entity.menssege,
      image: entity.image,
      datemade: entity.dateMade,
      createdat: entity.createAt,
      updatedat: entity.createAt,
    );
  }

  Notificacao toEntity() {
    return Notificacao(
      id: uid,
      menssege: menssege,
      titulo: titulo,
      dateMade: datemade,
      image: image,
      createAt: createdat ?? datemade,
      updateAt: updatedat ?? datemade,
    );
  }
}
