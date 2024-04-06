import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/config/route/route_handler.dart';
import 'package:restaurant_app/config/route/screen_routes.dart';
import 'package:restaurant_app/di/injection.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/detail/detail_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/home/home_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/home/home_event.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/search/search_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => sl()..add(const GetAllRestaurantEvent()),
        ),
        BlocProvider<DetailBloc>(create: (context) => sl()),
        BlocProvider<SearchBloc>(create: (context) => sl()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RestoApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        initialRoute: ScreenRoutes.home,
        onGenerateRoute: RouteHandler().onGenerateRoute,
      ),
    );
  }
}
