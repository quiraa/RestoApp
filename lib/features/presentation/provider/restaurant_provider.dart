import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/features/data/model/add_review/review_body.dart';
import 'package:restaurant_app/features/data/model/detail/detail_restaurant_response.dart';
import 'package:restaurant_app/features/data/model/list/list_restaurant_response.dart';
import 'package:restaurant_app/features/data/model/list/restaurant_item_response.dart';
import 'package:restaurant_app/features/data/services/api_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum ResultState {
  loading,
  noData,
  hasData,
  error,
}

class RestaurantProvider extends ChangeNotifier {
  final ApiService service;
  final Connectivity connectivity = Connectivity();

  RestaurantProvider({required this.service}) {
    fetchAllRestaurants();
  }

  late ResultState _state;
  late ListRestaurantResponse _restaurantResponse;
  late DetailRestaurantResponse _detailResponse;
  List<RestaurantItemResponse> _searchList = [];
  // List<CustomerReviewResponse> _reviewList = [];
  String _message = '';

  ResultState get state => _state;
  ListRestaurantResponse get restaurantResponse => _restaurantResponse;
  DetailRestaurantResponse get detailResponse => _detailResponse;
  List<RestaurantItemResponse> get searchList => _searchList;
  // List<CustomerReviewResponse> get reviewList => _reviewList;
  String get message => _message;

  Future<void> fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final responseData = await service.getAllRestaurants();
      if (responseData.data.restaurants!.isEmpty) {
        _state = ResultState.noData;
        _message = 'No Data Found';
      } else {
        _state = ResultState.hasData;
        _restaurantResponse = responseData.data;
      }
    } on DioException catch (e) {
      _state = ResultState.error;
      debugPrint('ERROR onFetchAllRestaurant: $e');
      _message = 'Please Check Your Internet Connection';
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchSingleRestaurant(String restaurantId) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final responseData = await service.getDetailRestaurants(id: restaurantId);
      if (responseData.response.statusCode == HttpStatus.ok) {
        _state = ResultState.hasData;
        _detailResponse = responseData.data;
      } else {
        _state = ResultState.noData;
        _message = 'No Data';
      }
    } on DioException catch (e) {
      _state = ResultState.error;
      debugPrint('ERROR onFetchSingleRestaurant: $e');
      _message = 'Please Check Your Internet Connection';
    } finally {
      notifyListeners();
    }
  }

  Future<void> postRestaurantReview(ReviewBody body) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final responseData = await service.addCustomerReview(body: body);
      final newReview = responseData.data.customerReviews!.last;
      _detailResponse.restaurant!.customerReviews!.add(newReview);
      _state = ResultState.hasData;
      _message = 'Review posted successfully';
      notifyListeners();
    } on DioException catch (e) {
      _state = ResultState.error;
      _message = 'Error: ${e.message}';
      debugPrint('Error: ${e.message}');
    }
  }

  Future<void> searchRestaurants(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final responseData = await service.searchRestaurant(query: query);
      if (responseData.data.restaurants!.isEmpty) {
        _state = ResultState.noData;
        _message = 'No Data Found';
      } else {
        _state = ResultState.hasData;
        _searchList = responseData.data.restaurants ?? [];
      }
    } on DioException catch (e) {
      _state = ResultState.error;
      debugPrint('ERROR onSearchRestaurant: $e');
      _message = 'Please Check Your Internet Connection';
    } finally {
      notifyListeners();
    }
  }
}
