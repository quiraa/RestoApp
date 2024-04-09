import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/features/data/model/response/list/list_restaurant_response.dart';

abstract class HomeState extends Equatable {
  final ListRestaurantResponse? restaurants;
  final DioException? error;

  const HomeState({this.error, this.restaurants});

  @override
  List<Object?> get props => [restaurants!, error!];
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeErrorState extends HomeState {
  const HomeErrorState(DioException error) : super(error: error);
}

class HomeSuccessState extends HomeState {
  const HomeSuccessState(ListRestaurantResponse restaurants)
      : super(restaurants: restaurants);
}
