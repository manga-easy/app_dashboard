import 'package:dashboard_manga_easy/core/services/apis/api_toggle.dart';
import 'package:dashboard_manga_easy/modules/toggles/data/dtos/create_toggle_dto.dart';
import 'package:dashboard_manga_easy/modules/toggles/domain/entities/toggle_entity.dart';

class ToggleRepositoryV1 {
  final ApiToggle _apiToggle;

  ToggleRepositoryV1(this._apiToggle);

  Future<void> create({required CreateToggleDto dto}) async {
    await _apiToggle.post('', body: dto.toJson());
  }

  Future<void> update({
    required CreateToggleDto dto,
    required String id,
  }) async {
    await _apiToggle.post(id, body: dto.toJson());
  }

  Future<List<ToggleEntity>> list({String? name}) async {
    String param = '';
    if (name != null) {
      param = '?name=$name';
    }
    final response = await _apiToggle.get('search$param');
    return response.map<ToggleEntity>((e) => ToggleEntity.fromJson(e)).toList();
  }
}
