import 'package:json_annotation/json_annotation.dart';

part 'customer_review_response.g.dart';

@JsonSerializable()
class CustomerReviewResponse {
  final String? name;
  final String? review;
  final String? date;

  const CustomerReviewResponse({this.name, this.review, this.date});

  factory CustomerReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerReviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerReviewResponseToJson(this);
}
