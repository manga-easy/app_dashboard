import 'package:dashboard_manga_easy/core/services/appwrite_old.dart';

class BannerModel {
  static const String collectionID = '61c64c7fd5d94';
  String id;
  String title;
  String subtitle;
  String btnText;
  String actionBtnBgColor;
  String image;
  String link;
  String gradientColors1;
  String gradientColors2;

  BannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.btnText,
    required this.actionBtnBgColor,
    required this.image,
    required this.link,
    required this.gradientColors1,
    required this.gradientColors2,
  });

  BannerModel.fromJson(Map<String, dynamic> json)
      : id = json['\$id'],
        title = json['title'],
        subtitle = json['subtitle'],
        btnText = json['btnText'],
        actionBtnBgColor = json['actionBtnBgColor'],
        image = json['image'],
        link = json['link'],
        gradientColors1 = json['gradientColors1'],
        gradientColors2 = json['gradientColors2'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    //data['\$id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['btnText'] = btnText;
    data['actionBtnBgColor'] = actionBtnBgColor;
    data['image'] = image;
    data['link'] = link;
    data['gradientColors1'] = gradientColors1;
    data['gradientColors2'] = gradientColors2;
    return data;
  }

  static Future<List<BannerModel>> getOldApp() async {
    final List<BannerModel> emblemas = [];
    final app = await AppwriteOld().inicia();
    for (var i = 0; i < 30000; i++) {
      var favos = await app.database.listDocuments(
        collectionId: BannerModel.collectionID,
        limit: 100,
        offset: 100 * i,
      );
      print(favos.documents.length);
      if (favos.documents.isEmpty) break;
      for (var favo in favos.documents) {
        emblemas.add(BannerModel.fromJson(favo.data));
      }
    }
    return emblemas;
  }
}
