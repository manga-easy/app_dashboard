import 'package:dashboard_manga_easy/services/appwrite.dart';
import 'package:dashboard_manga_easy/services/appwrite_old.dart';
import 'package:get/get.dart';

class Users {
  String id;
  String name;
  int registration;
  bool status;
  int passwordUpdate;
  String email;
  bool emailVerification;
  Prefs prefs;

  Users({
    required this.id,
    required this.name,
    required this.registration,
    required this.status,
    required this.passwordUpdate,
    required this.email,
    required this.emailVerification,
    required this.prefs,
  });

  Users.fromJson(Map<String, dynamic> json)
      : id = json['\$id'],
        name = json['name'],
        registration = json['registration'],
        status = json['status'],
        passwordUpdate = json['passwordUpdate'],
        email = json['email'],
        emailVerification = json['emailVerification'],
        prefs = Prefs.fromJson(json['prefs']['data']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$id'] = id;
    data['name'] = name;
    data['registration'] = registration;
    data['status'] = status;
    data['passwordUpdate'] = passwordUpdate;
    data['email'] = email;
    data['emailVerification'] = emailVerification;
    data['prefs'] = prefs.toJson();
    return data;
  }

  static Future<String?> findUserOld(String user) async {
    final app = await AppwriteOld().inicia();
    for (var i = 0; i < 30000; i++) {
      var favos = await app.users.list(
        limit: 25,
        offset: 25 * i,
        search: removeCoisas(user),
      );
      for (var item in favos.users) {
        if (user.contains(item.email)) {
          return item.$id;
        }
      }
    }
    return null;
  }

  static Future<String?> findUserNew(String user) async {
    final app = Get.find<Appwrite>();
    for (var i = 0; i < 30000; i++) {
      var favos = await app.users.list(
        limit: 100,
        offset: 100 * i,
        search: removeCoisas(user),
      );
      for (var item in favos.users) {
        if (user.contains(item.email)) {
          return item.$id;
        }
      }
    }
    return null;
  }

  static String removeCoisas(String email) {
    return email.substring(0, email.indexOf('@'));
  }
}

class Prefs {
  String? provider;
  String? tokenFcm;
  Prefs({this.tokenFcm});

  Prefs.fromJson(Map<String, dynamic> json)
      : provider = json['provider'],
        tokenFcm = json['tokenFcm'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['tokenFcm'] = tokenFcm;
    data['provider'] = provider;
    return data;
  }
}
