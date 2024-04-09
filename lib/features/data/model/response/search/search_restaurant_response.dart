import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/features/data/model/response/list/restaurant_item_response.dart';

part 'search_restaurant_response.g.dart';

@JsonSerializable()
class SearchRestaurantResponse {
  final bool? error;
  final int? founded;
  final List<RestaurantItemResponse>? restaurants;

  SearchRestaurantResponse({
    this.error,
    this.founded,
    this.restaurants,
  });

  factory SearchRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchRestaurantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchRestaurantResponseToJson(this);
}
