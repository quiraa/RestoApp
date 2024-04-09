import 'package:restaurant_app/core/usecases/use_case.dart';
import 'package:restaurant_app/features/domain/repository/restaurant_repository.dart';

class RemoveFavoriteUseCase implements UseCase<void, String> {
  final RestaurantRepository repository;

  RemoveFavoriteUseCase(this.repository);

  @override
  Future<void> call({String? params}) {
    return repository.deleteFavorite(params!);
  }
}
