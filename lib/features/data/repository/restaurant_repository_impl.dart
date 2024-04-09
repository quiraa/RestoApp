import 'dart:io';

import 'package:dio/dio.dart';
import 'package:restaurant_app/core/data_state/data_state.dart';
import 'package:restaurant_app/features/data/model/favorite/favorite_restaurant.dart';
import 'package:restaurant_app/features/data/model/response/add_review/add_review_response.dart';
import 'package:restaurant_app/features/data/model/response/add_review/review_body.dart';
import 'package:restaurant_app/features/data/model/response/detail/detail_restaurant_response.dart';
import 'package:restaurant_app/features/data/model/response/list/list_restaurant_response.dart';
import 'package:restaurant_app/features/data/model/response/search/search_restaurant_response.dart';
import 'package:restaurant_app/features/data/source/local/favorite_database.dart';
import 'package:restaurant_app/features/data/source/remote/api_service.dart';
import 'package:restaurant_app/features/domain/repository/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final ApiService api;
  final FavoriteDatabase database;

  RestaurantRepositoryImpl(this.api, this.database);

  @override
  Future<DataState<AddReviewResponse>> addCustomerReview(
      ReviewBody body) async {
    try {
      final responseData = await api.addCustomerReview(body: body);
      if (responseData.response.statusCode == HttpStatus.ok) {
        return DataSuccess(responseData.data);
      } else {
        return DataError(
          DioException(
            requestOptions: responseData.response.requestOptions,
            error: responseData.response.statusMessage,
            message: responseData.response.statusMessage,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<ListRestaurantResponse>> getAllRestaurants() async {
    try {
      final responseData = await api.getAllRestaurants();
      if (responseData.response.statusCode == HttpStatus.ok) {
        return DataSuccess(responseData.data);
      } else {
        return DataError(
          DioException(
            requestOptions: responseData.response.requestOptions,
            error: responseData.response.statusMessage,
            message: responseData.response.statusMessage,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<DetailRestaurantResponse>> getDetailRestaurant(
      String id) async {
    try {
      final responseData = await api.getDetailRestaurants(id: id);
      if (responseData.response.statusCode == HttpStatus.ok) {
        return DataSuccess(responseData.data);
      } else {
        return DataError(
          DioException(
            requestOptions: responseData.response.requestOptions,
            error: responseData.response.statusMessage,
            message: responseData.response.statusMessage,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<SearchRestaurantResponse>> searchRestaurant(
      String query) async {
    try {
      final responseData = await api.searchRestaurant(query: query);

      if (responseData.response.statusCode == HttpStatus.ok) {
        return DataSuccess(responseData.data);
      } else {
        return DataError(
          DioException(
            requestOptions: responseData.response.requestOptions,
            error: responseData.response.statusMessage,
            message: responseData.response.statusMessage,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<List<FavoriteRestaurant>> getAllFavorites() async {
    return database.dao.getAllFavorites();
  }

  @override
  Future<void> deleteFavorite(String id) async {
    return database.dao.deleteFavorite(id);
  }

  @override
  Future<void> insertFavorite(FavoriteRestaurant favorite) async {
    return database.dao.insertFavorite(favorite);
  }
}
