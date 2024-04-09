import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/config/route/app_router.dart';
import 'package:restaurant_app/config/route/screen_routes.dart';
import 'package:restaurant_app/features/data/model/response/list/list_restaurant_response.dart';
import 'package:rxdart/rxdart.dart';

import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String?>();

class NotificationService {
  static NotificationService? _instance;

  NotificationService._internal() {
    _instance = this;
  }

  factory NotificationService() => _instance ?? NotificationService._internal();
  int randomIndex = Random().nextInt(20);

  static void requestAndroidPermissions(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static void requestIOSPermissions(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initAndroidSettings = const AndroidInitializationSettings('app_icon');

    var initIOSSettings = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initSettings = InitializationSettings(
      android: initAndroidSettings,
      iOS: initIOSSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload != null) {
          print('notification payload: $payload');
        }
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  // * Notification Methods

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    ListRestaurantResponse restaurants,
  ) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        "1", "notif_channel",
        channelDescription: "restaurant app channel",
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var notifTitle = "<b>Recommended Restaurants for You<b>";
    var restaurantName = restaurants.restaurants?[randomIndex].name;

    await flutterLocalNotificationsPlugin.show(
      0,
      notifTitle,
      restaurantName,
      platformChannelSpecifics,
      payload: json.encode(restaurants.toJson()),
    );
  }

  void configureSelectNotificationSubject(BuildContext context, String route) {
    selectNotificationSubject.stream.listen((String? payload) async {
      var data = ListRestaurantResponse.fromJson(
          json.decode(payload ?? 'empty payload'));
      print(data);
      var restaurant = data.restaurants?[randomIndex];
      AppRouter.push(context, ScreenRoutes.detail,
          arguments: restaurant?.id ?? '');
    });
  }
}
