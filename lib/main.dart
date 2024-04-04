import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/config/route/route_handler.dart';
import 'package:restaurant_app/config/route/screen_routes.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/features/data/services/api_service.dart';
import 'package:restaurant_app/features/presentation/page/home/home_page.dart';
import 'package:restaurant_app/features/presentation/provider/restaurant_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RestaurantProvider(service: ApiService(Dio())),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RestoApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: ScreenRoutes.home,
      onGenerateRoute: RouteHandler().onGenerateRoute,
    );
  }
}
