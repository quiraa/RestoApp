import 'package:restaurant_app/core/data_state/data_state.dart';
import 'package:restaurant_app/core/usecases/use_case.dart';
import 'package:restaurant_app/features/data/model/response/search/search_restaurant_response.dart';
import 'package:restaurant_app/features/domain/repository/restaurant_repository.dart';

class SearchRestaurantUseCase
    implements UseCase<DataState<SearchRestaurantResponse>, String> {
  final RestaurantRepository repository;

  SearchRestaurantUseCase(this.repository);

  @override
  Future<DataState<SearchRestaurantResponse>> call({String? params}) {
    return repository.searchRestaurant(params!);
  }
}
