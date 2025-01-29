import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter/src/navigation_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../route_names.dart';

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  // debugPrint('TITLE : ${message.notification?.title}');
  // debugPrint('BODY : ${message.notification?.body}');
  // debugPrint('PAYLOAD : ${message.data}');
  // String title = message.notification?.title ?? '';
  // String body = message.notification?.body ?? '';
  // int id = 1;
  // try {
  //   id = int.parse(message.data['notification_index']);
  // } catch (e) {
  //   id = 1;
  // }
  // ApiFirebase.showNotification(
  //   id: id,
  //   title: title,
  //   body: body,
  //   payload: 'TEST',
  //   fln: ApiFirebase.flutterLocalNotificationsPlugin,
  // );
}

class ApiFirebase {
  final firebaseMessaging = FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final String topic = ConstValue.ORG_CODE;

  Future<void> initNotifications() async {
    // FIREBASE MESSAGING
    NotificationSettings statusFirebaseMessaging =
        await firebaseMessaging.requestPermission();
    debugPrint(
        'statusFirebaseMessaging : ${statusFirebaseMessaging.authorizationStatus}');
    JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
    final fcmToken = await firebaseMessaging.getToken() ?? '';
    jupiterPrefsAndAppData.setNotiToken(fcmToken);
    String token = await jupiterPrefsAndAppData.getNotiToken();
    debugPrint('FIREBASE TOKEN : ${token}');
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    // firebaseMessaging.subscribeToTopic(topic);
    // LOCAL NOTIFICATION
    var androidInitialize =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSInitialize = new DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: onPressedNotification,
      // onDidReceiveBackgroundNotificationResponse:
      //     onPressedAppTerminateNotification,
    );
  }

  Future<String> getTokenNotification() async {
    JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
    String token = await jupiterPrefsAndAppData.getNotiToken();
    if (token != '') {
      debugPrint('RETURN NOTIFICATION TOKEN AT PREFERENCE : ${token}');
      return token;
    } else {
      final fcmToken = await firebaseMessaging.getToken() ?? '';
      jupiterPrefsAndAppData.setNotiToken(fcmToken);
      token = await jupiterPrefsAndAppData.getNotiToken();
      debugPrint('SAVE AND RETURN NOTIFICATION TOKEN AT PREFERENCE : ${token}');
      return token;
    }
  }

  Future<bool> checkLaunchAppFromNotification() async {
    bool checkLaunchApp =
        await firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) {
        return true;
      } else {
        return false;
      }
    });
    return checkLaunchApp;
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    List<String> split = url.split('/');
    List<String> splitType = split[split.length - 1].split('.');
    String type = '.${splitType[splitType.length - 1]}';
    String filePath = '';
    if (Platform.isIOS) {
      filePath = '${directory.path}/$fileName${type}';
    } else {
      filePath = '${directory.path}/$fileName';
    }
    debugPrint('url : ${url}');
    debugPrint('filePath : ${filePath}');
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  void firebaseListenMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      String title = message.notification?.title ?? '';
      String body = message.notification?.body ?? '';
      String imageUrl = '';
      int id = 1;
      NotificationDetails? notiDetail = null;
      try {
        id = int.parse(message.data['notification_index']);
      } catch (e) {
        id = 1;
      }
      if (Platform.isIOS) {
        imageUrl = message.notification?.apple?.imageUrl ?? '';
      } else {
        imageUrl = message.notification?.android?.imageUrl ?? '';
      }
      debugPrint('PAYLOAD : ${message.data}');
      if (imageUrl != '') {
        final String bigPicturePath =
            await _downloadAndSaveFile(imageUrl, 'image-notification');
        final BigPictureStyleInformation bigPictureStyleInformation =
            BigPictureStyleInformation(
          FilePathAndroidBitmap(bigPicturePath),
          largeIcon: FilePathAndroidBitmap(bigPicturePath),
          contentTitle: title,
          htmlFormatContentTitle: true,
          summaryText: body,
          htmlFormatSummaryText: true,
        );
        final AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
          'NOTIFICATION_ID',
          'Notfication',
          playSound: true,
          importance: Importance.max,
          priority: Priority.high,
          channelDescription: 'big text channel description',
          styleInformation: bigPictureStyleInformation,
        );
        DarwinNotificationDetails iosNotificationDetails =
            DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          attachments: [
            DarwinNotificationAttachment(
              bigPicturePath,
              identifier: 'notification_icon',
              hideThumbnail: false,
            ),
          ],
        );
        notiDetail = NotificationDetails(
          android: androidNotificationDetails,
          iOS: iosNotificationDetails,
        );
      }
      showNotification(
        id: id,
        title: title,
        body: body,
        payload: '',
        fln: flutterLocalNotificationsPlugin,
        notiDetail: notiDetail,
      );
    });
  }

  void firebaseListenMessageOpenApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      onPressdBackgroundNotification(message);
    });
  }

  void clearAllNotification() {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  void clearNotificationFromID(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }

  void onPressedNotification(NotificationResponse? response) {
    final GlobalKey<NavigatorState> _navigatorKey =
        getIt<NavigationService>().navigatorKey;
    final String? payload = response?.payload;
    if (response?.payload != null) {
      debugPrint('NOTI PAYLOAD: $payload');
    }
    try {
      bool canGoNotificationPage = false;
      _navigatorKey.currentState!.popUntil((route) {
        debugPrint('ROUTE : ${route.settings.name}');
        if (route.settings.name == RouteNames.unlock_screen_jupiter ||
            route.settings.name == RouteNames.mainmenu) {
          canGoNotificationPage = true;
          return true;
        } else if (route.settings.name == RouteNames.login) {
          canGoNotificationPage = false;
          return true;
        }
        return false;
      });
      if (canGoNotificationPage)
        _navigatorKey.currentState!.pushNamed(RouteNames.notification);
    } catch (e) {}
  }

  // void onPressedAppTerminateNotification(NotificationResponse? response) {
  //   final GlobalKey<NavigatorState> _navigatorKey =
  //       getIt<NavigationService>().navigatorKey;
  //   ScaffoldMessenger.of(_navigatorKey.currentState!.context).showSnackBar(
  //     const SnackBar(content: Text('ONPRESSED WH')),
  //   );
  // }

  void onPressdBackgroundNotification(RemoteMessage message) {
    final GlobalKey<NavigatorState> _navigatorKey =
        getIt<NavigationService>().navigatorKey;
    debugPrint('NOTI MESSAGE DATA : ${message.data}');
    try {
      bool canGoNotificationPage = false;
      _navigatorKey.currentState!.popUntil((route) {
        debugPrint('ROUTE : ${route.settings.name}');
        if (route.settings.name == RouteNames.unlock_screen_jupiter ||
            route.settings.name == RouteNames.mainmenu) {
          canGoNotificationPage = true;
          return true;
        } else if (route.settings.name == RouteNames.login) {
          canGoNotificationPage = false;
          return true;
        }
        return false;
      });
      if (canGoNotificationPage)
        _navigatorKey.currentState!.pushNamed(RouteNames.notification);
    } catch (e) {}
  }

  static Future showNotification({
    required int id,
    required String title,
    required String body,
    required var payload,
    required FlutterLocalNotificationsPlugin fln,
    required NotificationDetails? notiDetail,
  }) async {
    debugPrint('notiDetail is null : ${notiDetail == null}');
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        new AndroidNotificationDetails(
      'NOTIFICATION_ID', 'Notfication',
      playSound: true, importance: Importance.max, priority: Priority.high,
      // actions: <AndroidNotificationAction>[
      //   AndroidNotificationAction('1', 'Action 1'),
      //   AndroidNotificationAction('2', 'Action 2'),
      //   AndroidNotificationAction('3', 'Action 3'),
      // ],
    );
    var notiDefault = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
      ),
    );

    try {
      await fln.show(
        id,
        title,
        body,
        notiDetail != null ? notiDetail : notiDefault,
      );
    } catch (e) {
      await fln.show(
        id,
        title,
        body,
        notiDefault,
      );
    }
  }
}
