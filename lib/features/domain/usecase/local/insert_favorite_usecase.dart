import 'package:restaurant_app/core/usecases/use_case.dart';
import 'package:restaurant_app/features/data/model/favorite/favorite_restaurant.dart';
import 'package:restaurant_app/features/domain/repository/restaurant_repository.dart';

class InsertFavoriteUseCase implements UseCase<void, FavoriteRestaurant> {
  final RestaurantRepository repository;

  InsertFavoriteUseCase(this.repository);

  @override
  Future<void> call({FavoriteRestaurant? params}) {
    return repository.insertFavorite(params!);
  }
}
