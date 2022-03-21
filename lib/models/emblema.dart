import 'package:dashboard_manga_easy/services/appwrite_old.dart';

class Emblema {
  static String get collectionId => '61b11b625f4b7';
  String id;
  String name;
  int timeCria;
  String rarity;
  String description;
  double percent;
  String url;
  List<String> benefits;
  bool adsOff;
  bool disponivel;
  String type;
  String categoria;

  Emblema({
    required this.id,
    required this.name,
    required this.timeCria,
    required this.rarity,
    required this.description,
    required this.percent,
    required this.url,
    required this.benefits,
    required this.adsOff,
    required this.disponivel,
    required this.type,
    required this.categoria,
  });

  Emblema.fromJson(dynamic json)
      : id = json['\$id'],
        name = json['name'],
        timeCria = json['time_cria'],
        rarity = json['rarity'],
        description = json['description'],
        percent = json['percent'],
        url = json['url'],
        adsOff = json['adsOff'],
        disponivel = json['disponivel'],
        type = json['type'],
        categoria = json['categoria'],
        benefits = json['benefits'].map<String>((e) => e.toString()).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['\$id'] = id;
    data['name'] = name;
    data['time_cria'] = timeCria;
    data['rarity'] = rarity;
    data['description'] = description;
    data['percent'] = percent;
    data['url'] = url;
    data['benefits'] = benefits;
    data['adsOff'] = adsOff;
    data['disponivel'] = disponivel;
    data['type'] = type;
    data['categoria'] = categoria;
    return data;
  }

  static Future<List<Emblema>> getOldApp() async {
    final List<Emblema> emblemas = [];
    final app = await AppwriteOld().inicia();
    for (var i = 0; i < 30000; i++) {
      var favos = await app.database.listDocuments(
        collectionId: Emblema.collectionId,
        limit: 100,
        offset: 100 * i,
      );
      print(favos.documents.length);
      if (favos.documents.isEmpty) break;
      for (var favo in favos.documents) {
        emblemas.add(Emblema.fromJson(favo.data));
      }
    }
    return emblemas;
  }
}
