import 'package:dashboard_manga_easy/core/services/apis/api_monolito.dart';
import 'package:dashboard_manga_easy/modules/users/data/dtos/user_dto.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:dashboard_manga_easy/modules/users/domain/repositories/users_repository.dart';

class UsersRepositoryV1 implements UsersRepository {
  final ApiMonolith _apiMonolito;

  UsersRepositoryV1(this._apiMonolito);

  String get feature => 'users';

  @override
  Future<void> creatDocument({required User objeto}) async {
    await _apiMonolito.post(
      '$feature/v1',
      body: UserDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<void> deletDocument({required String id}) async {
    await _apiMonolito.delete('$feature/v1/$id');
  }

  @override
  Future<User?> getDocument({required String id}) async {
    final ret = await _apiMonolito.get('$feature/v1/$id');
    if (ret.isEmpty) {
      return null;
    }
    return UserDto.fromMap(ret).toEntity();
  }

  @override
  Future<void> updateDocument({required User objeto}) async {
    await _apiMonolito.post(
      '$feature/v1/${objeto.id}',
      body: UserDto.fromEntity(objeto).toMap(),
    );
  }

  @override
  Future<List<User>> listDocument({String? search}) async {
    String params = '';
    if (search != null) {
      params += 'search=$search';
    }
    final result = await _apiMonolito.get(
      '$feature/v1?$params',
    );

    return result.map<User>((e) => UserDto.fromMap(e).toEntity()).toList();
  }
}
