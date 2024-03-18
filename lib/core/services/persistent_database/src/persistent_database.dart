abstract class PersistentDatabase<T> {
  abstract final String version;

  Future<void> starting();

  Future<List<Map<String, dynamic>>> list({where, required T store});

  Future<Map<String, dynamic>?> get({required String id, required T store});

  Future<String> create({
    required Map<String, dynamic> objeto,
    required T store,
    String? id,
  });

  Future<void> update({
    required Map<String, dynamic> objeto,
    required T store,
    required String id,
  });

  Future<void> delete({required String id, required T store});

  Future<void> deleteAll({required T store});
}
