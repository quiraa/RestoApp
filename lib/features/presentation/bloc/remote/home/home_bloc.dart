import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/data_state/data_state.dart';
import 'package:restaurant_app/features/domain/usecase/remote/get_all_restaurant_usecase.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/home/home_event.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllRestaurantUseCase getAllRestaurantUseCase;

  HomeBloc(this.getAllRestaurantUseCase) : super(const HomeLoadingState()) {
    on<GetAllRestaurantEvent>(onGetAllRestaurant);
  }

  void onGetAllRestaurant(
    GetAllRestaurantEvent event,
    Emitter<HomeState> emit,
  ) async {
    final restaurants = await getAllRestaurantUseCase();

    if (restaurants is DataSuccess) {
      emit(HomeSuccessState(restaurants.data!.restaurants!));
    }

    if (restaurants is DataError) {
      emit(HomeErrorState(restaurants.error!));
    }
  }
}
