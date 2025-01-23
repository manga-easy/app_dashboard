import 'package:dashboard_manga_easy/modules/host/data/repositories/host_repository_v1.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_entity.dart';
import 'package:dashboard_manga_easy/modules/host/domain/entities/host_status_enum.dart';
import 'package:page_manager/entities/state_manager.dart';
import 'package:page_manager/manager_store.dart';

class HostController extends ManagerStore {
  final HostRepositoryV1 _hostRepository;

  HostController(this._hostRepository);

  var list = <HostEntity>[];
  String _search = '';
  String get searchHost => _search.toLowerCase();

  @override
  void init(Map<String, dynamic> arguments) {
    loadingHost();
  }

  Future<void> loadingHost() async {
    try {
      state = StateManager.loading;
      list = await _hostRepository.listDocument();
      list.sort((a, b) {
        if (a.status == b.status) {
          return a.order.compareTo(b.order);
        }
        return a.status == HostStatus.disable ? 1 : -1;
      });
      state = StateManager.done;
    } catch (e) {
      state = StateManager.error;
      rethrow;
    }
  }

  set searchHost(String value) {
    _search = value;
    notifyListeners();
  }

  void changStatus(HostEntity host) => handleTry(
        call: () async {
          host.status = host.status == HostStatus.disable
              ? HostStatus.enable
              : HostStatus.disable;
          await _hostRepository.updateDocument(
            objeto: host.toDto(),
            id: host.id,
          );
          list = await _hostRepository.listDocument();
        },
      );
}
