abstract class ILocalData {
  Map<String, dynamic>? get({required String table, required String id});

  Future<void> delet({required String table, required String id});

  Future<void> deletAll({required String table});

  Future<void> createUpdate({required String table, required Map<String, dynamic> dados, String? id});
  List<Map<String, dynamic>> list({required String table, String? orderField, bool desc = true});
}
