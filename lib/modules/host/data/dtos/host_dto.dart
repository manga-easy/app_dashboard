import 'package:dashboard_manga_easy/modules/host/domain/entities/host_model.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_status_enum.dart';

class HostDto {
  final String? uid;
  final int idhost;
  final int order;
  final String name;
  final String host;
  final String status;
  final String interstitialadunitid;
  final bool isbeta;

  const HostDto({
    required this.uid,
    required this.idhost,
    required this.order,
    required this.name,
    required this.host,
    required this.status,
    required this.interstitialadunitid,
    required this.isbeta,
  });

  factory HostDto.fromEntity(HostModel entity) {
    return HostDto(
      uid: entity.id,
      idhost: entity.idHost,
      order: entity.order,
      name: entity.name,
      host: entity.host,
      status: entity.status.name,
      interstitialadunitid: entity.interstitialAdUnitId,
      isbeta: entity.isbeta,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'idhost': idhost,
      'order': order,
      'name': name,
      'host': host,
      'status': status,
      'interstitialadunitid': interstitialadunitid,
      'isbeta': isbeta,
    };
  }

  factory HostDto.fromMap(Map<String, dynamic> map) {
    return HostDto(
      uid: map['uid'],
      idhost: map['idhost'],
      order: map['order'],
      name: map['name'],
      host: map['host'],
      status: map['status'],
      interstitialadunitid: map['interstitialadunitid'],
      isbeta: map['isbeta'] ?? false,
    );
  }

  HostModel toEntity() {
    return HostModel(
      id: uid,
      name: name,
      host: host,
      order: order,
      status: HostStatus.getStatus(status),
      interstitialAdUnitId: interstitialadunitid,
      idHost: idhost,
      isbeta: isbeta,
    );
  }
}
