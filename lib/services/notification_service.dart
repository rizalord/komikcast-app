import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:komikcast/data/comic_data.dart';
import 'package:komikcast/data/init_data.dart';
import 'package:komikcast/models/comic_v3.dart';
import 'package:path_provider/path_provider.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  NotificationService() {
    notificationServe();
  }

  void notificationServe() async {
    Hive.init((await getApplicationDocumentsDirectory()).path);
    await Hive.openBox('komikcast');

    var db = Hive.box('komikcast');

    bool isNotified = db.get('isNotification', defaultValue: true);

    print('isNotified: $isNotified');

    if (isNotified) {
      var content = await getNotificationContent();

      if (content != null) {
        await initializing();
        _showNotifications(content);
      }
    }
  }

  Future<Map> getNotificationContent() async {
    final resData = await ComicData.getHomeData();
    List<ComicV3> listV3 = resData['latestChapter'];

    if (listV3.first.linkId != KomikcastSystem().getLastChapterId(db: Hive.box('komikcast'))) {
      KomikcastSystem()
          .setLastChapterId(listV3.first.linkId, db: Hive.box('komikcast'));
      return {
        'title': '[Update] ' + listV3.first.title,
        'body': listV3.first.chapters.first.title
      };
    } else {
      return null;
    }
  }

  Future<void> initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications(Map content) async {
    await notification(content);
  }

  Future<void> notification(Map content) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'Channel _ID', 'Channel title', 'Channel body',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        0, content['title'], content['body'], notificationDetails);
  }

  Future onSelectNotification(String payload) {
    if (payload != null) {
      print(payload);
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            print('Cupertino Pressed');
          },
          child: Text('Okay'),
        ),
      ],
    );
  }
}
