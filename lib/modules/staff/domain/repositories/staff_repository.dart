import 'package:dashboard_manga_easy/core/services/apis/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/staff/data/dtos/staff_dto.dart';
import 'package:dashboard_manga_easy/modules/staff/domain/models/staff_entity.dart';

class StaffRepository {
  final ApiMonolith _monolith;
  final String _path = 'staff/v1';

  StaffRepository(this._monolith);

  Future<List<StaffEntity>> list() async {
    final data = await _monolith.get(_path);

    if (data.isEmpty) {
      return [];
    }

    return data
        .map<StaffEntity>((item) => StaffDto.fromJson(item).toEntity())
        .toList();
  }

  Future<List<StaffEntity>> getById({required String id}) async {
    final data = await _monolith.get('$_path/$id');

    if (data.isEmpty) {
      return [];
    }

    return [StaffDto.fromJson(data).toEntity()];
  }

  Future<List<StaffEntity>> getByUserId({required String userId}) async {
    final Map<String, dynamic> data =
        await _monolith.get('$_path/users/$userId');

    if (data.isEmpty) {
      return [];
    }

    final staffDto = StaffDto.fromJson(data);
    return [staffDto.toEntity()];
  }

  Future<void> post({required StaffDto body}) async {
    await _monolith.post(_path, body: body.toJson());
  }

  Future<void> delete({required String id}) async {
    await _monolith.delete('$_path/$id');
  }

  Future<void> put({required String id, required StaffDto body}) async {
    await _monolith.put('$_path/$id', body: body.toJson());
  }
}
