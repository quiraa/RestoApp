import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurant_app/features/data/repository/restaurant_repository_impl.dart';
import 'package:restaurant_app/features/data/source/remote/api_service.dart';
import 'package:restaurant_app/features/domain/repository/restaurant_repository.dart';
import 'package:restaurant_app/features/domain/usecase/remote/add_review_usecase.dart';
import 'package:restaurant_app/features/domain/usecase/remote/get_all_restaurant_usecase.dart';
import 'package:restaurant_app/features/domain/usecase/remote/get_detail_restaurant_usecase.dart';
import 'package:restaurant_app/features/domain/usecase/remote/search_restaurant_usecase.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/detail/detail_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/home/home_bloc.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/search/search_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<ApiService>(ApiService(sl()));

  sl.registerSingleton<RestaurantRepository>(RestaurantRepositoryImpl(sl()));

  sl.registerSingleton<SearchRestaurantUseCase>(SearchRestaurantUseCase(sl()));

  sl.registerSingleton<GetAllRestaurantUseCase>(GetAllRestaurantUseCase(sl()));

  sl.registerSingleton<GetDetailRestaurantUseCase>(
    GetDetailRestaurantUseCase(sl()),
  );

  sl.registerSingleton<AddReviewUseCase>(AddReviewUseCase(sl()));

  sl.registerFactory<HomeBloc>(() => HomeBloc(sl()));
  sl.registerFactory<DetailBloc>(() => DetailBloc(sl(), sl()));
  sl.registerFactory<SearchBloc>(() => SearchBloc(sl()));
}
