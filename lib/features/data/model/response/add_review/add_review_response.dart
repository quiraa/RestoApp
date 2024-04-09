import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/features/data/model/response/add_review/customer_review_response.dart';

part 'add_review_response.g.dart';

@JsonSerializable()
class AddReviewResponse {
  final bool? error;
  final String? message;
  final List<CustomerReviewResponse>? customerReviews;

  AddReviewResponse({this.error, this.message, this.customerReviews});

  factory AddReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$AddReviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddReviewResponseToJson(this);
}
