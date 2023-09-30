import 'package:affirmation_flutter_app/pages/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: androidSetting, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification(
     {
      int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduleNotificationDateTime
    }) async {

      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      if (scheduleNotificationDateTime.isBefore(now) || scheduleNotificationDateTime.isAtSameMomentAs(now)) {
        debugPrint("DateTime is now or before");
        return;
      }

      return notificationsPlugin.zonedSchedule(
        id, 
        title = "Daily Affirmation",
        body = "$myQuote",
        tz.TZDateTime.from(
          scheduleNotificationDateTime,
          tz.local
        ), 
        await notificationDetails(), 
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
        );
  }
}