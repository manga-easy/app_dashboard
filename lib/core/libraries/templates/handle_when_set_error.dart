import 'package:dashboard_manga_easy/core/services/auth/auth_exception.dart';
import 'package:page_manager/export_manager.dart';
import 'package:page_manager/handles/manager_handle_when_set_error.dart';

class HandleWhenSetError implements ManagerHandleWhenSetError {
  @override
  StateManager call(Object? e) {
    if (e is AuthException && e.errorCode == 'general_unauthorized_scope') {
      return StateManager.loggedOut;
    }
    return StateManager.error;
  }
}
