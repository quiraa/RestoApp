import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_app/features/data/model/response/detail/detail_restaurant_response.dart';

abstract class DetailState extends Equatable {
  final DetailRestaurantResponse? detailRestaurant;
  final DioException? error;

  const DetailState({this.detailRestaurant, this.error});

  @override
  List<Object?> get props => [detailRestaurant!, error!];
}

class DetailLoadingState extends DetailState {
  const DetailLoadingState();
}

class DetailSuccessState extends DetailState {
  const DetailSuccessState(DetailRestaurantResponse detailRestaurant)
      : super(detailRestaurant: detailRestaurant);
}

class DetailErrorState extends DetailState {
  const DetailErrorState(DioException error) : super(error: error);
}

class PostReviewSuccessState extends DetailState {
  const PostReviewSuccessState();
}
