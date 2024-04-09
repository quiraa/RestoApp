import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:restaurant_app/core/utils/notification_service.dart';
import 'package:restaurant_app/features/data/source/remote/api_service.dart';
import 'package:restaurant_app/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._createObject();

  factory BackgroundService() {
    _service ??= BackgroundService._createObject();
    return _service!;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final notifService = NotificationService();
    var result = await ApiService(Dio()).getAllRestaurants();
    int randomIndex = Random().nextInt(20);

    await notifService.showNotification(
      localNotificationPlugin,
      result.data.restaurants![randomIndex],
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
    print('Alarm Running');
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}
