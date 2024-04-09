import 'package:restaurant_app/core/data_state/data_state.dart';
import 'package:restaurant_app/core/usecases/use_case.dart';
import 'package:restaurant_app/features/data/model/response/detail/detail_restaurant_response.dart';
import 'package:restaurant_app/features/domain/repository/restaurant_repository.dart';

class GetDetailRestaurantUseCase
    implements UseCase<DataState<DetailRestaurantResponse>, String> {
  final RestaurantRepository repository;

  GetDetailRestaurantUseCase(this.repository);

  @override
  Future<DataState<DetailRestaurantResponse>> call({String? params}) {
    return repository.getDetailRestaurant(params!);
  }
}
