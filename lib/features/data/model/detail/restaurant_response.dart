import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/features/data/model/add_review/customer_review_response.dart';

part 'restaurant_response.g.dart';

@JsonSerializable()
class RestaurantResponse {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final Menu? menus;
  final double? rating;
  final List<CustomerReviewResponse>? customerReviews;

  RestaurantResponse({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
    this.customerReviews,
  });

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantResponseToJson(this);
}

@JsonSerializable()
class Menu {
  final List<Food>? foods;
  final List<Drink>? drinks;

  Menu({
    this.foods,
    this.drinks,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}

@JsonSerializable()
class Food {
  final String? name;

  Food({this.name});

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  Map<String, dynamic> toJson() => _$FoodToJson(this);
}

@JsonSerializable()
class Drink {
  final String? name;

  Drink({this.name});

  factory Drink.fromJson(Map<String, dynamic> json) => _$DrinkFromJson(json);

  Map<String, dynamic> toJson() => _$DrinkToJson(this);
}
