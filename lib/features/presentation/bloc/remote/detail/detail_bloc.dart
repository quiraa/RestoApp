import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/core/data_state/data_state.dart';
import 'package:restaurant_app/features/domain/usecase/remote/add_review_usecase.dart';
import 'package:restaurant_app/features/domain/usecase/remote/get_detail_restaurant_usecase.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/detail/detail_event.dart';
import 'package:restaurant_app/features/presentation/bloc/remote/detail/detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetDetailRestaurantUseCase getDetailRestaurantUseCase;
  final AddReviewUseCase addReviewUseCase;

  DetailBloc(
    this.getDetailRestaurantUseCase,
    this.addReviewUseCase,
  ) : super(const DetailLoadingState()) {
    on<GetDetailRestaurantEvent>(onGetDetailRestaurant);
    on<AddCustomerReviewEvent>(onAddCustomerReview);
  }

  void onGetDetailRestaurant(
    GetDetailRestaurantEvent event,
    Emitter<DetailState> emit,
  ) async {
    final dataState = await getDetailRestaurantUseCase(
      params: event.restaurantId,
    );

    if (dataState is DataSuccess) {
      emit(DetailSuccessState(dataState.data!));
    }

    if (dataState is DataError) {
      emit(DetailErrorState(dataState.error!));
    }
  }

  void onAddCustomerReview(
    AddCustomerReviewEvent event,
    Emitter<DetailState> emit,
  ) async {
    emit(const DetailLoadingState());
    await addReviewUseCase(params: event.body);
    emit(const PostReviewSuccessState());
  }
}
