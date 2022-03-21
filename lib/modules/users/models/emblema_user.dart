import 'package:dashboard_manga_easy/core/services/appwrite_old.dart';

class EmblemaUser {
  static String get collectionId => '61b3be0d89c8a';
  String? id;
  String idEmblema;
  int timeCria;
  String userId;

  EmblemaUser({
    this.id,
    required this.timeCria,
    required this.userId,
    required this.idEmblema,
  });

  EmblemaUser.fromJson(dynamic json)
      : id = json['\$id'],
        timeCria = json['timeCria'],
        idEmblema = json['idEmblema'],
        userId = json['userId'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['\$id'] = id;
    data['idEmblema'] = idEmblema;
    data['timeCria'] = timeCria;
    data['userId'] = userId;

    return data;
  }

  static Future<List<EmblemaUser>> getOldApp(String user) async {
    final List<EmblemaUser> mangas = [];
    final app = await AppwriteOld().inicia();
    for (var i = 0; i < 30000; i++) {
      var favos = await app.database.listDocuments(
        collectionId: EmblemaUser.collectionId,
        limit: 100,
        offset: 100 * i,
        filters: [
          'userId=$user',
        ],
      );
      if (favos.documents.isEmpty) break;
      for (var favo in favos.documents) {
        mangas.add(EmblemaUser.fromJson(favo.data));
      }
    }
    return mangas;
  }
}
