import 'package:dashboard_manga_easy/core/services/auth/auth_service.dart';
import 'package:dashboard_manga_easy/core/services/routers/service_route.dart';

class LogoffService {
  final AuthService _authService;
  final ServiceRoute _serviceRoute;

  LogoffService(this._authService, this._serviceRoute);

  Future<void> call() async {
    _serviceRoute.permissions = null;
    ServiceRoute.userId = null;
    await _authService.deleteSession();
  }
}
