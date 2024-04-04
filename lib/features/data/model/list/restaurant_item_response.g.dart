// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantItemResponse _$RestaurantItemResponseFromJson(
        Map<String, dynamic> json) =>
    RestaurantItemResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      pictureId: json['pictureId'] as String?,
      city: json['city'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RestaurantItemResponseToJson(
        RestaurantItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'pictureId': instance.pictureId,
      'city': instance.city,
      'rating': instance.rating,
    };
