import 'package:dashboard_manga_easy/modules/host/domain/repositories/host_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class UpdateHostCase {
  final HostRepository hostRepository;

  UpdateHostCase(this.hostRepository);

  Future<void> call(HostModel host) async {
    if (host.name.isEmpty) {
      throw Exception('Nome não pode ser vazio');
    }
    if (host.host.isEmpty) {
      throw Exception('Url não pode ser vazio');
    }
    if (host.interstitialAdUnitId.isEmpty) {
      throw Exception('interstitialAdUnitId não pode ser vazio');
    }
    await hostRepository.updateDocument(objeto: host);
  }
}
