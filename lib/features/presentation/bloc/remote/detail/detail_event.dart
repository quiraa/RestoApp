import 'package:restaurant_app/features/data/model/add_review/review_body.dart';

abstract class DetailEvent {
  final String? restaurantId;
  final ReviewBody? body;

  const DetailEvent({this.restaurantId, this.body});
}

class GetDetailRestaurantEvent extends DetailEvent {
  const GetDetailRestaurantEvent(String id) : super(restaurantId: id);
}

class AddCustomerReviewEvent extends DetailEvent {
  const AddCustomerReviewEvent(ReviewBody body) : super(body: body);
}
