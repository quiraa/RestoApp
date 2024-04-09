import 'package:json_annotation/json_annotation.dart';

part 'restaurant_item_response.g.dart';

@JsonSerializable()
class RestaurantItemResponse {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final double? rating;

  RestaurantItemResponse({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  factory RestaurantItemResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantItemResponseToJson(this);
}
