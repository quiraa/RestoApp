import 'package:flutter/material.dart';
import 'package:restaurant_app/config/route/screen_routes.dart';
import 'package:restaurant_app/core/utils/background_service.dart';
import 'package:restaurant_app/core/utils/notification_service.dart';
import 'package:restaurant_app/features/presentation/page/favorite/favorite_page.dart';
import 'package:restaurant_app/features/presentation/page/home/home_page.dart';
import 'package:restaurant_app/features/presentation/page/search/search_page.dart';
import 'package:restaurant_app/features/presentation/page/settings/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _notificationService = NotificationService();
  final _backgroundService = BackgroundService();

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _backgroundService.someTask());
    _notificationService.configureSelectNotificationSubject(
      context,
      ScreenRoutes.detail,
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  int _index = 0;

  final _screens = <Widget>[
    const HomePage(),
    SearchPage(),
    const FavoritePage(),
    const SettingsPage()
  ];

  void _onNavigationTapped(int index) {
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: _buildBottomNavbar(),
    );
  }

  Widget _buildBottomNavbar() {
    return NavigationBar(
      destinations: _buildBottomNavBarItems(),
      selectedIndex: _index,
      onDestinationSelected: (index) => _onNavigationTapped(index),
    );
  }

  List<Widget> _buildBottomNavBarItems() {
    return [
      const NavigationDestination(
        selectedIcon: Icon(Icons.home),
        icon: Icon(Icons.home_outlined),
        label: 'Home',
        tooltip: 'Home',
      ),
      const NavigationDestination(
        selectedIcon: Icon(Icons.search),
        icon: Icon(Icons.search),
        label: 'Search',
        tooltip: 'Search',
      ),
      const NavigationDestination(
        selectedIcon: Icon(Icons.favorite),
        icon: Icon(Icons.favorite_outline),
        label: 'Favorite',
        tooltip: 'Favorite',
      ),
      const NavigationDestination(
        selectedIcon: Icon(Icons.settings),
        icon: Icon(Icons.settings_outlined),
        label: 'Settings',
        tooltip: 'Settings',
      ),
    ];
  }
}
