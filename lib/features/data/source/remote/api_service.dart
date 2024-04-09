import 'package:dio/dio.dart';
import 'package:restaurant_app/features/data/model/response/add_review/review_body.dart';
import 'package:restaurant_app/features/data/model/response/search/search_restaurant_response.dart';
import 'package:retrofit/retrofit.dart';

import 'package:restaurant_app/core/constants/constants.dart' as Constants;
import 'package:restaurant_app/features/data/model/response/add_review/add_review_response.dart';
import 'package:restaurant_app/features/data/model/response/detail/detail_restaurant_response.dart';
import 'package:restaurant_app/features/data/model/response/list/list_restaurant_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('/list')
  Future<HttpResponse<ListRestaurantResponse>> getAllRestaurants();

  @GET('/detail/{id}')
  Future<HttpResponse<DetailRestaurantResponse>> getDetailRestaurants({
    @Path('id') String? id,
  });

  @POST('/review')
  Future<HttpResponse<AddReviewResponse>> addCustomerReview({
    @Header('Content-Type') String? contentType = 'application/json',
    @Body() ReviewBody? body,
  });

  @GET('/search')
  Future<HttpResponse<SearchRestaurantResponse>> searchRestaurant({
    @Query('q') String? query,
  });
}
