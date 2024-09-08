import 'package:dashboard_manga_easy/modules/host/domain/entities/host_entity.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_status_enum.dart';

class CreateHostDto {
  int hostId;
  int order;
  String name;
  String urlApi;
  HostStatus status;

  CreateHostDto({
    required this.hostId,
    required this.order,
    required this.name,
    required this.urlApi,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'hostId': hostId,
      'order': order,
      'name': name,
      'urlApi': urlApi,
      'status': status.name,
    };
  }

  factory CreateHostDto.empty() {
    return CreateHostDto(
      hostId: 0,
      order: 0,
      name: '',
      urlApi: '',
      status: HostStatus.disable,
    );
  }
  factory CreateHostDto.fromEntity(HostEntity entity) {
    return CreateHostDto(
      hostId: entity.hostId,
      order: entity.order,
      name: entity.name,
      urlApi: entity.urlApi,
      status: entity.status,
    );
  }
}
