import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificFCM extends GetxService {
  String? token;
  late Stream<String> tokenStream;
  Future<NotificFCM> inicia() async {
    /// await Firebase.initializeApp();
    await AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'resource://drawable/ic_launcher',
        [
          NotificationChannel(
              channelKey: 'Geral',
              channelName: 'Notificações em geral',
              channelDescription: 'Notificações Basicas em geral',
              defaultColor: Colors.white,
              ledColor: Colors.white)
        ]);
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    // if (await Helps.verificarConexao()) {
    //   await FirebaseMessaging.instance.subscribeToTopic('avisos');
    // }
    // firebaseMessaging();
    return this;
  }

  Future<void> showFullScreenNotification(
      {required int id, required String title, required String body}) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'Geral',
        title: title,
        body: body,
      ),
    );
  }

  Future<void> showprogressNotification(
      {required int id, required String title, required String body, required int progress}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'Geral',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.ProgressBar,
        progress: progress,
      ),
    );
  }

  Future<void> showDefaltNotication({
    required int id,
    required String title,
    required String body,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'Geral',
        title: title,
        body: body,
      ),
    );
  }

  void notificacaoDeToque() {
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      Get.toNamed('/NotificationPage', arguments: {
        "receive": receivedNotification
      } // your page params. I recommend to you to pass all *receivedNotification* object
          );
    });
  }
}
