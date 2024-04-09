// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantResponse _$RestaurantResponseFromJson(Map<String, dynamic> json) =>
    RestaurantResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      pictureId: json['pictureId'] as String?,
      city: json['city'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      menus: json['menus'] == null
          ? null
          : Menu.fromJson(json['menus'] as Map<String, dynamic>),
      customerReviews: (json['customerReviews'] as List<dynamic>?)
          ?.map(
              (e) => CustomerReviewResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantResponseToJson(RestaurantResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'pictureId': instance.pictureId,
      'city': instance.city,
      'menus': instance.menus,
      'rating': instance.rating,
      'customerReviews': instance.customerReviews,
    };

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      foods: (json['foods'] as List<dynamic>?)
          ?.map((e) => Food.fromJson(e as Map<String, dynamic>))
          .toList(),
      drinks: (json['drinks'] as List<dynamic>?)
          ?.map((e) => Drink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'foods': instance.foods,
      'drinks': instance.drinks,
    };

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'name': instance.name,
    };

Drink _$DrinkFromJson(Map<String, dynamic> json) => Drink(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$DrinkToJson(Drink instance) => <String, dynamic>{
      'name': instance.name,
    };
