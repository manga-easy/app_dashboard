import 'package:dashboard_manga_easy/modules/host/domain/repositories/host_repository.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class ListHostCase {
  final HostRepository hostRepository;

  ListHostCase(this.hostRepository);
  Future<List<HostModel>> call() async {
    return await hostRepository.listDocument();
  }
}
