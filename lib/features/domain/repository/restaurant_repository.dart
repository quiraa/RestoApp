import 'package:restaurant_app/core/data_state/data_state.dart';
import 'package:restaurant_app/features/data/model/add_review/add_review_response.dart';
import 'package:restaurant_app/features/data/model/add_review/review_body.dart';
import 'package:restaurant_app/features/data/model/detail/detail_restaurant_response.dart';
import 'package:restaurant_app/features/data/model/list/list_restaurant_response.dart';
import 'package:restaurant_app/features/data/model/search/search_restaurant_response.dart';

abstract class RestaurantRepository {
  Future<DataState<ListRestaurantResponse>> getAllRestaurants();

  Future<DataState<DetailRestaurantResponse>> getDetailRestaurant(String id);

  Future<DataState<AddReviewResponse>> addCustomerReview(ReviewBody body);

  Future<DataState<SearchRestaurantResponse>> searchRestaurant(String query);
}
