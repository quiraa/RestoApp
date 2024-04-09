import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/features/data/model/response/list/restaurant_item_response.dart';

part 'list_restaurant_response.g.dart';

@JsonSerializable()
class ListRestaurantResponse {
  final bool? error;
  final String? message;
  final int? count;
  final List<RestaurantItemResponse>? restaurants;

  const ListRestaurantResponse({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  factory ListRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$ListRestaurantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListRestaurantResponseToJson(this);
}
