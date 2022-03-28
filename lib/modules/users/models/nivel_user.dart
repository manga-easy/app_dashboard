import 'package:dashboard_manga_easy/core/services/appwrite_old.dart';

class NivelUser {
  static String get collectionId => '61b1215aa06cb';
  String? id;
  String name;
  int total;
  String temporada;
  int lvl;
  int timeCria;
  int quantity;
  int minute;
  String userId;
  int timeUp;

  NivelUser({
    this.id,
    required this.timeCria,
    required this.lvl,
    required this.quantity,
    required this.minute,
    required this.userId,
    required this.timeUp,
    required this.name,
    required this.total,
    required this.temporada,
  });

  NivelUser.fromJson(dynamic json)
      : id = json['\$id'],
        timeCria = json['timeCria'],
        lvl = json['lvl'],
        quantity = json['quantity'],
        userId = json['userId'],
        timeUp = json['timeUp'],
        name = json['name'] ?? '',
        temporada = json['temporada'] ?? '',
        total = json['total'] ?? 0,
        minute = json['minute'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\$id'] = id;
    data['lvl'] = lvl;
    data['timeCria'] = timeCria;
    data['quantity'] = quantity;
    data['userId'] = userId;
    data['minute'] = minute;
    data['timeUp'] = timeUp;
    data['name'] = name;
    data['temporada'] = temporada;
    data['total'] = total;
    return data;
  }

  static Future<List<NivelUser>> getOldApp(String user) async {
    final List<NivelUser> mangas = [];
    final app = await AppwriteOld().inicia();
    for (var i = 0; i < 30000; i++) {
      var favos = await app.database.listDocuments(
        collectionId: NivelUser.collectionId,
        limit: 100,
        offset: 100 * i,
        filters: [
          'userId=$user',
        ],
      );
      if (favos.documents.isEmpty) break;
      for (var favo in favos.documents) {
        mangas.add(NivelUser.fromJson(favo.data));
      }
    }
    return mangas;
  }
}
