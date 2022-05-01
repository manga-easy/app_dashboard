import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dashboard_manga_easy/core/services/service.dart';
import 'package:flutter/material.dart';

class NotificFCM extends IService {
  String? token;
  late Stream<String> tokenStream;
  Future<NotificFCM> inicia() async {
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

  @override
  Future<void> initialise() async {
    if (!Platform.isWindows) {
      await AwesomeNotifications().initialize(
        'resource://drawable/ic_launcher',
        [
          NotificationChannel(
              channelKey: 'Geral',
              channelName: 'Notificações em geral',
              channelDescription: 'Notificações Basicas em geral',
              defaultColor: Colors.white,
              ledColor: Colors.white)
        ],
      );
      await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
    }
  }
}
