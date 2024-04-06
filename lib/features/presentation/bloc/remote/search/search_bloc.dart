import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/data_state/data_state.dart';
import 'package:restaurant_app/features/domain/usecase/remote/search_restaurant_usecase.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/search/search_event.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRestaurantUseCase searchRestaurantUseCase;

  SearchBloc(this.searchRestaurantUseCase) : super(const SearchInitialState()) {
    on<SearchRestaurantEvent>(onSearchRestaurant);
  }

  void onSearchRestaurant(
    SearchRestaurantEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchLoadingState());
    final dataState = await searchRestaurantUseCase(
      params: event.query,
    );

    if (dataState is DataSuccess) {
      emit(SearchSuccessState(dataState.data!.restaurants!));
    }

    if (dataState.data!.restaurants!.isEmpty) {
      emit(const SearchEmptyState());
    }

    if (dataState is DataError) {
      emit(SearchErrorState(dataState.error!));
    }
  }
}
