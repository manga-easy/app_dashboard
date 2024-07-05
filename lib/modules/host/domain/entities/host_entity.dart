import 'package:dashboard_manga_easy/modules/host/data/dtos/create_host_dto.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_status_enum.dart';

class HostEntity {
  final String id;
  final int hostId;
  final int order;
  final String name;
  final String urlApi;
  HostStatus status;
  final int createdAt;
  final int updatedAt;

  HostEntity({
    required this.id,
    required this.hostId,
    required this.order,
    required this.name,
    required this.urlApi,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HostEntity.fromJson(Map<String, dynamic> json) {
    return HostEntity(
      id: json['id'],
      hostId: json['hostId'],
      order: json['order'],
      name: json['name'],
      urlApi: json['urlApi'],
      status: HostStatus.getStatus(json['status']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  CreateHostDto toDto({HostStatus? status}) {
    return CreateHostDto(
      hostId: hostId,
      order: order,
      name: name,
      urlApi: urlApi,
      status: status ?? this.status,
    );
  }
}
