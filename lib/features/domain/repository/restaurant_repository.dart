import 'package:restaurant_app/core/data_state/data_state.dart';
import 'package:restaurant_app/features/data/model/favorite/favorite_restaurant.dart';
import 'package:restaurant_app/features/data/model/response/add_review/add_review_response.dart';
import 'package:restaurant_app/features/data/model/response/add_review/review_body.dart';
import 'package:restaurant_app/features/data/model/response/detail/detail_restaurant_response.dart';
import 'package:restaurant_app/features/data/model/response/list/list_restaurant_response.dart';
import 'package:restaurant_app/features/data/model/response/search/search_restaurant_response.dart';

abstract class RestaurantRepository {
  Future<DataState<ListRestaurantResponse>> getAllRestaurants();

  Future<DataState<DetailRestaurantResponse>> getDetailRestaurant(String id);

  Future<DataState<AddReviewResponse>> addCustomerReview(ReviewBody body);

  Future<DataState<SearchRestaurantResponse>> searchRestaurant(String query);

  Future<List<FavoriteRestaurant>> getAllFavorites();

  Future<void> deleteFavorite(String id);

  Future<void> insertFavorite(FavoriteRestaurant favorite);
}
