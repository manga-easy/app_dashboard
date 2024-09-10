import 'package:dashboard_manga_easy/modules/notificacao/dominio/models/notificacao.dart';

class CreateNotificationDto {
  String title;
  String? message;
  String? image;

  CreateNotificationDto({
    required this.title,
    required this.message,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'message': message,
      'image': image,
    };
  }

  factory CreateNotificationDto.empty() {
    return CreateNotificationDto(
      title: '',
      message: '',
      image: '',
    );
  }

  factory CreateNotificationDto.fromEntity(Notificacao entity) {
    return CreateNotificationDto(
      title: entity.title,
      message: entity.message,
      image: entity.image,
    );
  }
}
