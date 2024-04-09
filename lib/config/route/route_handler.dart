import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/config/route/screen_routes.dart';
import 'package:restaurant_app/features/presentation/page/detail/detail_page.dart';
import 'package:restaurant_app/features/presentation/page/main_page.dart';

class RouteHandler {
  PageRoute _getPageRoute({String? routeName, Widget? screen}) {
    return CupertinoPageRoute(
      builder: (_) => screen!,
      settings: RouteSettings(name: routeName),
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoutes.home:
        return _getPageRoute(
          routeName: ScreenRoutes.home,
          screen: const MainPage(),
        );

      case ScreenRoutes.detail:
        final restaurantId = settings.arguments as String;
        return _getPageRoute(
          routeName: ScreenRoutes.detail,
          screen: DetailPage(restaurantId: restaurantId),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Routes defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
