import 'dart:io';

import 'package:dio/dio.dart';
import 'package:restaurant_app/core/data_state/data_state.dart';
import 'package:restaurant_app/features/data/model/add_review/add_review_response.dart';
import 'package:restaurant_app/features/data/model/add_review/review_body.dart';
import 'package:restaurant_app/features/data/model/detail/detail_restaurant_response.dart';
import 'package:restaurant_app/features/data/model/list/list_restaurant_response.dart';
import 'package:restaurant_app/features/data/model/search/search_restaurant_response.dart';
import 'package:restaurant_app/features/data/source/remote/api_service.dart';
import 'package:restaurant_app/features/domain/repository/restaurant_repository.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final ApiService api;

  RestaurantRepositoryImpl(this.api);

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
}
