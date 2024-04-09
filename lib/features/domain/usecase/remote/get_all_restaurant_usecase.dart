import 'package:restaurant_app/core/data_state/data_state.dart';
import 'package:restaurant_app/core/usecases/use_case.dart';
import 'package:restaurant_app/features/data/model/response/list/list_restaurant_response.dart';
import 'package:restaurant_app/features/domain/repository/restaurant_repository.dart';

class GetAllRestaurantUseCase
    implements UseCase<DataState<ListRestaurantResponse>, void> {
  final RestaurantRepository repository;

  GetAllRestaurantUseCase(this.repository);

  @override
  Future<DataState<ListRestaurantResponse>> call({void params}) {
    return repository.getAllRestaurants();
  }
}
