import 'package:dashboard_manga_easy/core/services/persistent_database/persistent_database.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class PersistentDatabaseSembast implements PersistentDatabase<StoreSembast> {
  final Map<StoreSembast, Box> _dbs = {};
  Box _getdb(StoreSembast e) => _dbs[e]!;
  @override
  Future<void> starting() async {
    await Hive.initFlutter();

    for (final element in StoreSembast.values) {
      final db = await Hive.openBox(element.name);
      _dbs[element] = db;
    }
  }

  @override
  Future<void> delete({
    required String id,
    required StoreSembast store,
  }) async {
    await _getdb(store).delete(id);
  }

  @override
  Future<Map<String, dynamic>?> get({
    required String id,
    required StoreSembast store,
  }) async {
    final result = _getdb(store).get(id);
    if (result == null) {
      return null;
    }
    return Map.from(_getdb(store).get(id));
  }

  @override
  Future<void> deleteAll({required StoreSembast store}) async {
    await _getdb(store).deleteFromDisk();
  }

  @override
  Future<String> create({
    required Map<String, dynamic> objeto,
    required StoreSembast store,
    String? id,
  }) async {
    id ??= const Uuid().v4();
    objeto['id'] = id;
    await _getdb(store).put(id, objeto);
    return id;
  }

  @override
  String get version => throw UnimplementedError();

  @override
  Future<void> update({
    required Map<String, dynamic> objeto,
    required StoreSembast store,
    required String id,
  }) async {
    if (id.isEmpty) {
      throw Exception('Id não pode ser vazio');
    }
    await _getdb(store).put(id, objeto);
  }

  @override
  Future<List<Map<String, dynamic>>> list({
    where,
    required StoreSembast store,
  }) async {
    final result = _getdb(store).values.map((e) => Map.from(e)).toList();
    return result.map((e) => Map<String, dynamic>.from(e)).toList();
  }
}
