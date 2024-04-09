import 'package:floor/floor.dart';

@Entity(tableName: 'favorite')
class FavoriteRestaurant {
  @primaryKey
  final String? id;
  final String? imageUrl;
  final String? name;
  final String? city;
  final String? rating;
  bool? isFavorite;

  FavoriteRestaurant({
    this.id,
    this.imageUrl,
    this.name,
    this.city,
    this.rating,
    this.isFavorite = false,
  });
}
