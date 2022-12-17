import 'package:dashboard_manga_easy/modules/host/domain/repositories/host_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class DeleteHostCase {
  final HostRepository hostRepository;

  DeleteHostCase(this.hostRepository);

  Future<void> call(HostModel host) async {
    await hostRepository.deletDocument(id: host.id!);
  }
}
