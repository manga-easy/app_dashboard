import 'package:dashboard_manga_easy/core/services/apis/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/update_notes/data/dtos/update_notes_dto.dart';
import 'package:dashboard_manga_easy/modules/update_notes/domain/update_notes_entity.dart';

class UpdateNotesRepository {
  final ApiMonolith _monolith;

  UpdateNotesRepository(this._monolith);

  Future<List<UpdateNotesEntity>> get() async {
    final data = await _monolith.get('release-note/v1');
    if (data is List && data.isNotEmpty) {
      return data
          .map((item) => UpdateNotesDto.fromJson(item).toEntity())
          .toList();
    }
    return [];
  }

  Future<UpdateNotesDto> getById({required String id}) async {
    final data = await _monolith.get('release-note/v1/$id');
    return UpdateNotesDto.fromJson(data);
  }

  Future<UpdateNotesDto> getByVersion({required String version}) async {
    final data = await _monolith.get('release-note/v1/version/$version');
    return UpdateNotesDto.fromJson(data);
  }

  Future<void> post({required UpdateNotesDto body}) async {
    await _monolith.post(
      'release-note/v1',
      body: body.toJson(),
    );
  }

  Future<void> put({required String id, required UpdateNotesDto body}) async {
    await _monolith.put(
      'release-note/v1/$id',
      body: body.toJson(),
    );
  }

  Future<void> delete({required String id}) async {
    await _monolith.delete('release-note/v1/$id');
  }
}
