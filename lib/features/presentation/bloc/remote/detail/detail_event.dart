import 'package:equatable/equatable.dart';
import 'package:restaurant_app/features/data/model/response/add_review/review_body.dart';

abstract class DetailEvent extends Equatable {
  final String? restaurantId;
  final ReviewBody? body;

  const DetailEvent({this.restaurantId, this.body});

  @override
  List<Object?> get props => [restaurantId!, body!];
}

class GetDetailRestaurantEvent extends DetailEvent {
  const GetDetailRestaurantEvent(String id) : super(restaurantId: id);
}

class AddCustomerReviewEvent extends DetailEvent {
  const AddCustomerReviewEvent(ReviewBody body) : super(body: body);
}
