import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:ride_sharing_user_app/helper/display_helper.dart';
import 'package:ride_sharing_user_app/util/app_constants.dart';

class NotificationHelper {

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    AndroidInitializationSettings androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // TODO: Route
        // try{
        //   if(payload != null && payload.isNotEmpty) {
        //     Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(payload)));
        //   }else {
        //     Get.toNamed(RouteHelper.getNotificationRoute());
        //   }
        // }catch (e) {}
        return;
      },
      onDidReceiveBackgroundNotificationResponse: myBackgroundMessageReceiver,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {    AndroidInitializationSettings androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // TODO: Route
        // try{
        //   if(payload != null && payload.isNotEmpty) {
        //     Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(payload)));
        //   }else {
        //     Get.toNamed(RouteHelper.getNotificationRoute());
        //   }
        // }catch (e) {}
        return;
      },
      onDidReceiveBackgroundNotificationResponse: myBackgroundMessageReceiver,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      customPrint('onMessage: ${message.data}');
      NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      customPrint('onOpenApp: ${message.data}');
    });

    customPrint('onMessage: ${message.data}');
      NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      customPrint('onOpenApp: ${message.data}');
    });
  }

  static Future<void> showNotification(RemoteMessage message, FlutterLocalNotificationsPlugin fln, bool data) async {
    String title = message.data['title'];
    String body = message.data['body'];
    String? orderID = message.data['order_id'];
    String? image = (message.data['image'] != null && message.data['image'].isNotEmpty)
        ? message.data['image'].startsWith('http') ? message.data['image']
        : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}' : null;

    try{
      await showBigPictureNotificationHiddenLargeIcon(title, body, orderID, image, fln);
    }catch(e) {
      await showBigPictureNotificationHiddenLargeIcon(title, body, orderID, null, fln);
      customPrint('Failed to show notification: ${e.toString()}');
    }
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(String title, String body, String? orderID, String? image, FlutterLocalNotificationsPlugin fln) async {
    String? largeIconPath;
    String? bigPicturePath;
    BigPictureStyleInformation? bigPictureStyleInformation;
    BigTextStyleInformation? bigTextStyleInformation;
    if(image != null && !GetPlatform.isWeb) {
      largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
      bigPicturePath = largeIconPath;
      bigPictureStyleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true,
        contentTitle: title, htmlFormatContentTitle: true,
        summaryText: body, htmlFormatSummaryText: true,
      );
    }else {
      bigTextStyleInformation = BigTextStyleInformation(
        body, htmlFormatBigText: true,
        contentTitle: title, htmlFormatContentTitle: true,
      );
    }
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '6amTech', '6amTech', priority: Priority.max, importance: Importance.max, playSound: true,
      largeIcon: largeIconPath != null ? FilePathAndroidBitmap(largeIconPath) : null,
      styleInformation: largeIconPath != null ? bigPictureStyleInformation : bigTextStyleInformation,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage remoteMessage) async {
  customPrint('onBackground: ${remoteMessage.data}');
  // var androidInitialize = new AndroidInitializationSettings('notification_icon');
  // var iOSInitialize = new IOSInitializationSettings();
  // var initializationsSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  // NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);
}

Future<dynamic> myBackgroundMessageReceiver(NotificationResponse response) async {
  customPrint('onBackgroundClicked: ${response.payload}');
}