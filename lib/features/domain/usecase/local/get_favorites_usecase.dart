import 'package:restaurant_app/core/usecases/use_case.dart';
import 'package:restaurant_app/features/data/model/favorite/favorite_restaurant.dart';
import 'package:restaurant_app/features/domain/repository/restaurant_repository.dart';

class GetFavoriteUseCase implements UseCase<List<FavoriteRestaurant>, void> {
  final RestaurantRepository repository;

  GetFavoriteUseCase(this.repository);

  @override
  Future<List<FavoriteRestaurant>> call({void params}) {
    return repository.getAllFavorites();
  }
}
