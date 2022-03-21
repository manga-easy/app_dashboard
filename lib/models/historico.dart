import 'dart:convert' as j;
import 'package:dashboard_manga_easy/config/app_helpes.dart';
import 'package:dashboard_manga_easy/models/chapter.dart';
import 'package:dashboard_manga_easy/models/manga.dart';
import 'package:dashboard_manga_easy/services/appwrite_old.dart';

class Historico {
  static String get collectionId => '617b5e10b202a';
  String? id;
  String idManga;
  String uniqueid;
  Manga? manga;
  String idUser;
  Chapter? capAtual;
  int dataUp;
  DateTime dataCria;
  bool deletado;
  List chapterLidos;

  Historico({
    this.capAtual,
    required this.dataCria,
    required this.idManga,
    required this.dataUp,
    required this.deletado,
    required this.idUser,
    required this.manga,
    required this.chapterLidos,
    required this.uniqueid,
  });

  Historico.fromJson(dynamic json)
      : id = json['\$id'] ?? json['id'],
        idManga = json['idManga'],
        uniqueid = AppHelps.convertUniqueid(json['idManga']),
        capAtual = json['capAtual'] != null ? Chapter.fromJson(AppHelps.decode(json['capAtual'])) : null,
        idUser = json['idUser'],
        dataUp = validaDatatime(json['dataUp']),
        deletado = json['deletado'] ?? false,
        chapterLidos = validaChaprterLido(json['chapterLidos']),
        manga = json['manga'] != null && json['manga'] != ""
            ? Manga.fromJson(AppHelps.decode(json['manga']))
            : null,
        dataCria = json['dataCria'] is DateTime ? json['dataCria'] : DateTime.parse(json['dataCria']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    //data['\$id'] = this.id;
    data['idManga'] = idManga;
    data['dataUp'] = dataUp;
    data['deletado'] = deletado;
    data['uniqueid'] = uniqueid;
    data['manga'] = manga != null ? j.json.encode(manga!.toJson()) : null;
    data['capAtual'] = capAtual != null ? j.json.encode(capAtual!.toJson()) : null;
    data['dataCria'] = dataCria.toString();
    data['chapterLidos'] = chapterLidos;
    data['idUser'] = idUser;

    return data;
  }

  static validaDatatime(data) {
    if (data == null || data is DateTime) {
      return DateTime.now().millisecondsSinceEpoch;
    }
    return data;
  }

  static validaChaprterLido(data) {
    if (data == null || data is String) {
      return [];
    }
    return data;
  }

  static Future<List<Historico>> getOldApp(String user) async {
    final List<Historico> mangas = [];
    final app = await AppwriteOld().inicia();
    for (var i = 0; i < 30000; i++) {
      var favos = await app.database.listDocuments(
        collectionId: Historico.collectionId,
        limit: 100,
        offset: 100 * i,
        filters: [
          'idUser=$user',
        ],
      );
      if (favos.documents.isEmpty) break;
      for (var favo in favos.documents) {
        mangas.add(Historico.fromJson(favo.data));
      }
    }
    return mangas;
  }
}
