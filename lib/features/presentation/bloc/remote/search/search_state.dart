import 'package:dio/dio.dart';
import 'package:restaurant_app/features/data/model/list/restaurant_item_response.dart';

abstract class SearchState {
  final List<RestaurantItemResponse>? restaurants;
  final DioException? error;

  const SearchState({this.restaurants, this.error});
}

class SearchInitialState extends SearchState {
  const SearchInitialState();
}

class SearchEmptyState extends SearchState {
  const SearchEmptyState();
}

class SearchLoadingState extends SearchState {
  const SearchLoadingState();
}

class SearchSuccessState extends SearchState {
  const SearchSuccessState(List<RestaurantItemResponse> restaurants)
      : super(restaurants: restaurants);
}

class SearchErrorState extends SearchState {
  const SearchErrorState(DioException error) : super(error: error);
}
