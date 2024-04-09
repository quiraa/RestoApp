import 'package:floor/floor.dart';
import 'package:restaurant_app/features/data/model/favorite/favorite_restaurant.dart';

@dao
abstract class FavoriteDao {
  @Query('SELECT * FROM favorite ORDER BY name ASC')
  Future<List<FavoriteRestaurant>> getAllFavorites();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFavorite(FavoriteRestaurant favorite);

  @Query('DELETE FROM favorite WHERE id = :favoriteId')
  Future<void> deleteFavorite(String favoriteId);
}
