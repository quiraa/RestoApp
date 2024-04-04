import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/features/data/model/detail/restaurant_response.dart';

part 'detail_restaurant_response.g.dart';

@JsonSerializable()
class DetailRestaurantResponse {
  final bool? error;
  final String? message;
  final RestaurantResponse? restaurant;

  DetailRestaurantResponse({
    this.error,
    this.message,
    this.restaurant,
  });

  factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailRestaurantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailRestaurantResponseToJson(this);
}
