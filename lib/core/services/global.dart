import 'package:dashboard_manga_easy/core/services/service.dart';

class Global extends IService {
  String? user;
  Future<Global> inicia() async {
    return this;
  }

  @override
  Future<void> initialise() async {}
}
