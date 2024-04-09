import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/config/route/route_handler.dart';
import 'package:restaurant_app/config/route/screen_routes.dart';
import 'package:restaurant_app/core/utils/background_service.dart';
import 'package:restaurant_app/core/utils/notification_service.dart';
import 'package:restaurant_app/di/injection.dart' as Injection;
import 'package:restaurant_app/features/presentation/bloc/local/favorite_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/local/favorite_event.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/detail/detail_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/home/home_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/home/home_event.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/search/search_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/setting/setting_bloc.dart';
import 'package:restaurant_app/config/route/app_router.dart' as Router;

final localNotificationPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection.initializeDependencies();
  final service = BackgroundService();
  final notificationService = NotificationService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationService.initNotification(localNotificationPlugin);
  NotificationService.requestAndroidPermissions(localNotificationPlugin);
  NotificationService.requestIOSPermissions(localNotificationPlugin);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const RestoApp());
}

class RestoApp extends StatelessWidget {
  const RestoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) =>
              Injection.sl()..add(const GetAllRestaurantEvent()),
        ),
        BlocProvider<DetailBloc>(create: (context) => Injection.sl()),
        BlocProvider<SearchBloc>(create: (context) => Injection.sl()),
        BlocProvider<FavoriteBloc>(
          create: (context) => Injection.sl()..add(const GetAllFavoriteEvent()),
        ),
        BlocProvider<SettingBloc>(create: (context) => Injection.sl())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RestoApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
          useMaterial3: true,
        ),
        navigatorKey: Router.navigatorKey,
        initialRoute: ScreenRoutes.home,
        onGenerateRoute: RouteHandler().onGenerateRoute,
      ),
    );
  }
}
