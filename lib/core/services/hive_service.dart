import 'package:dashboard_manga_easy/core/interfaces/service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';
import 'package:uuid/uuid.dart';

class HiveDb extends IService {
  final String tableNotFound = 'Tabela não existe';
  late Box general;

  Map<String, dynamic>? get({required String table, required String id}) {
    var box = switchBox(table);
    if (box == null) throw Exception(tableNotFound);
    var dados = box.get(id);
    if (dados == null) return null;
    return Map<String, dynamic>.from(dados);
  }

  Future<void> delet({required String table, required String id}) async {
    var box = switchBox(table);
    if (box == null) throw Exception(tableNotFound);
    await box.delete(id);
  }

  Future<void> deletAll({required String table}) async {
    var box = switchBox(table);
    if (box == null) throw Exception(tableNotFound);
    await box.clear();
  }

  Future<void> createUpdate({required String table, required IModelData dados}) async {
    var box = switchBox(table);
    if (box == null) throw Exception(tableNotFound);
    dados.id ??= const Uuid().v4();
    await box.put(dados.id, dados.toJson());
  }

  List<Map<String, dynamic>> list({required String table, String? orderField, bool desc = true}) {
    var box = switchBox(table);
    if (box == null) throw Exception(tableNotFound);
    var dados = box.values.map((e) => Map<String, dynamic>.from(e)).toList();
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
    switch (table) {
      case 'general':
        return general;
      default:
        return null;
    }
  }

  @override
  Future<void> initialise() async {
    await Hive.initFlutter();
    general = await Hive.openBox('general');
  }
}
