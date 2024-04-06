import 'package:dio/dio.dart';
import 'package:restaurant_app/features/data/model/list/restaurant_item_response.dart';

abstract class HomeState {
  final List<RestaurantItemResponse>? restaurants;
  final DioException? error;

  const HomeState({this.error, this.restaurants});
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeErrorState extends HomeState {
  const HomeErrorState(DioException error) : super(error: error);
}

class HomeSuccessState extends HomeState {
  const HomeSuccessState(List<RestaurantItemResponse> restaurants)
      : super(restaurants: restaurants);
}
