import 'package:dashboard_manga_easy/core/services/apis/api_response_parse/api_erros/api_error.dart';
import 'package:page_manager/export_manager.dart';

class HandleWhenGetRethrow implements ManagerHandleWhenGetRethrow {
  @override
  bool call(Object? e) {
    if (e is ApiError) {
      return true;
    }
    return false;
  }
}
