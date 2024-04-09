// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_restaurant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListRestaurantResponse _$ListRestaurantResponseFromJson(
        Map<String, dynamic> json) =>
    ListRestaurantResponse(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      count: json['count'] as int?,
      restaurants: (json['restaurants'] as List<dynamic>?)
          ?.map(
              (e) => RestaurantItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListRestaurantResponseToJson(
        ListRestaurantResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'count': instance.count,
      'restaurants': instance.restaurants,
    };
