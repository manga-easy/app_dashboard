import 'package:dashboard_manga_easy/core/services/persistent_database/persistent_database.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:uuid/uuid.dart';

class PersistentDatabaseSembast implements PersistentDatabase<StoreSembast> {
  late final Database _db;

  @override
  Future<void> starting() async {
    final dbFactory = kIsWeb ? databaseFactoryWeb : databaseFactoryIo;
    String dbName = 'sembast_v1.db';
    if (!kIsWeb) {
      final dir = await getApplicationDocumentsDirectory();
      dbName = join(dir.path, dbName);
    }
    // We use the database factory to open the database
    _db = await dbFactory.openDatabase(dbName);
  }

  @override
  Future<void> delete({
    required String id,
    required StoreSembast store,
  }) async {
    final storeref = StoreRef<String, dynamic>(store.name);
    await storeref.record(id).delete(_db);
  }

  @override
  Future<Map<String, dynamic>?> get({
    required String id,
    required StoreSembast store,
  }) async {
    final storeref = StoreRef<String, dynamic>(store.name);
    return await storeref.record(id).get(_db);
  }

  @override
  Future<void> deleteAll({required StoreSembast store}) async {
    final storeref = StoreRef<String, dynamic>(store.name);
    await storeref.drop(_db);
  }

  @override
  Future<String> create({
    required Map<String, dynamic> objeto,
    required StoreSembast store,
    String? id,
  }) async {
    final storeref = StoreRef<String, dynamic>(store.name);
    id ??= const Uuid().v4();
    objeto['id'] = id;
    await storeref.record(id).put(_db, objeto);
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
    final storeref = StoreRef<String, dynamic>(store.name);
    await storeref.record(id).put(_db, objeto);
  }

  @override
  Future<List<Map<String, dynamic>>> list({
    where,
    required StoreSembast store,
  }) async {
    final storeref = StoreRef<String, dynamic>(store.name);
    final result = await storeref.find(_db);
    return result.map((e) => Map<String, dynamic>.from(e.value)).toList();
  }
}
