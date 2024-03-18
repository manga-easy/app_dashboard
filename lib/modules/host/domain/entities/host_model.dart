import 'package:dashboard_manga_easy/modules/host/domain/entities/host_status_enum.dart';

class HostModel {
  String? id;
  int idHost;
  int order;
  String name;
  String host;
  HostStatus status;
  String interstitialAdUnitId;
  bool isbeta;

  HostModel({
    this.id,
    required this.name,
    required this.host,
    required this.order,
    required this.status,
    required this.interstitialAdUnitId,
    required this.idHost,
    required this.isbeta,
  });

  HostModel.fromJson(Map<String, dynamic> json)
      : id = json['\$id'],
        name = json['name'],
        order = json['order'],
        status = HostStatus.getStatus(json['status']),
        idHost = json['idHost'],
        isbeta = json['isbeta'] ?? false,
        interstitialAdUnitId = json['interstitialAdUnitId'],
        host = json['host'];

  HostModel.empty()
      : name = '',
        order = -1,
        status = HostStatus.disable,
        idHost = -1,
        isbeta = false,
        interstitialAdUnitId = '',
        host = '';

  Map<String, dynamic> toJson() {
    return {
      'status': status.name,
      '\$id': id,
      'name': name,
      'host': host,
      'order': order,
      'idHost': idHost,
      'isbeta': isbeta,
      'interstitialAdUnitId': interstitialAdUnitId,
    };
  }
}
