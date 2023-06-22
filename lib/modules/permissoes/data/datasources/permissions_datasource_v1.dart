import 'package:client_driver/client_driver.dart';
import 'package:dashboard_manga_easy/core/config/app_config.dart';
import 'package:dashboard_manga_easy/modules/permissoes/data/datasources/permissions_datasource.dart';
import 'package:dashboard_manga_easy/modules/permissoes/data/dtos/permissions_dto.dart';
import 'package:manga_easy_sdk/manga_easy_sdk.dart';

class PermissionsDatasourceV1 implements PermissionsDatasource {
  final String version = 'v1';
  final ClientRequest _driverHttp;
  final String _host = AppConfig.ipserver;
  final ApiResponseParser _apiResponseParser;

  PermissionsDatasourceV1(
    this._driverHttp,
    this._apiResponseParser,
  );

  @override
  Future<List<PermissionsDto>> list() async {
    final token = '';
    final response = await _driverHttp.get(
      path: '$_host/v1/permissions/list',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final result = _apiResponseParser.handleResponse(
      statusCode: response.statusCode,
      response: response.data,
    );
    return result.data.map((e) => PermissionsDto.fromMap(e)).toList();
  }
}
