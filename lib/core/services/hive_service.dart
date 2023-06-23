import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class TablesHive {
  Box table;
  final String name;
  TablesHive({required this.table, required this.name});
  static List<String> listTables = ['credencial', 'user'];
}

class HiveDb {
  final String tableNotFound = 'Tabela não existe';
  List<TablesHive> tables = [];

  Map<String, dynamic>? get({required String table, required String id}) {
    final box = switchBox(table);
    if (box == null) throw Exception(tableNotFound);
    final dados = box.get(id);
    if (dados == null) return null;
    return Map<String, dynamic>.from(dados);
  }

  Future<void> delet({required String table, required String id}) async {
    final box = switchBox(table);
    if (box == null) throw Exception(tableNotFound);
    await box.delete(id);
  }

  Future<void> deletAll({required String table}) async {
    final box = switchBox(table);
    if (box == null) throw Exception(tableNotFound);
    await box.clear();
  }

  Future<void> createUpdate({
    required String table,
    required Map<String, dynamic> dados,
    String? id,
  }) async {
    final box = switchBox(table);
    if (box == null) throw Exception(tableNotFound);
    id ??= const Uuid().v4();
    await box.put(id, dados);
  }

  List<Map<String, dynamic>> list({
    required String table,
    String? orderField,
    bool desc = true,
  }) {
    final box = switchBox(table);
    if (box == null) throw Exception(tableNotFound);
    final dados = box.values.map((e) => Map<String, dynamic>.from(e)).toList();
    if (orderField != null) {
      try {
        if (desc) {
          dados.sort((a, b) => b[orderField].compareTo(a[orderField]));
        } else {
          dados.sort((a, b) => a[orderField].compareTo(b[orderField]));
        }
      } catch (e) {
        throw Exception('Campo $orderField não existe ou está nulo');
      }
    }
    return dados;
  }

  Box? switchBox(String table) {
    try {
      return tables.firstWhere((element) => element.name == table).table;
    } catch (e) {
      return null;
    }
  }

  Future<void> initialise() async {
    await Hive.initFlutter();
    for (var element in TablesHive.listTables) {
      tables.add(
        TablesHive(
          table: await Hive.openBox(element),
          name: element,
        ),
      );
    }
  }
}
