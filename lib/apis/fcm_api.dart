import 'dart:convert';
import 'package:dashboard_manga_easy/config/app_config.dart';
import 'package:get/get.dart';

class FCMApi extends GetConnect {
  final String tokenServer = AppConfig.tokenServer;
  Future<bool> postMensagem({
    required List<dynamic> listtokens,
    required String msg,
    required String title,
    required String idmsg,
  }) async {
    String msgJson = '';
    if (listtokens.length == 1) {
      msgJson = jsonEncode({
        'to': listtokens.first,
        'notification': {'title': '$title', 'body': '$msg'},
        'data': {'msgId': '$idmsg'}
      });
    } else {
      msgJson = jsonEncode({
        'registration_ids': listtokens,
        'notification': {'title': '$title', 'body': '$msg'},
        'data': {'msgId': '$idmsg'}
      });
    }

    try {
      var result = await post(
        'https://fcm.googleapis.com/fcm/send',
        msgJson,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tokenServer'
        },
      );
      return result.isOk;
    } catch (e) {
      return false;
    }
  }

  Future<bool> postAviso({
    required List<dynamic> listtokens,
    required String msg,
    required String title,
    required String idmsg,
  }) async {
    var msgJson = jsonEncode({
      'to': '/topics/avisos',
      'notification': {'title': '$title', 'body': '$msg'},
      'data': {'msgId': '$idmsg'}
    });
    try {
      var result = await post(
        'https://fcm.googleapis.com/fcm/send',
        msgJson,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $tokenServer'
        },
      );
      return result.isOk;
    } catch (e) {
      return false;
    }
  }
}
