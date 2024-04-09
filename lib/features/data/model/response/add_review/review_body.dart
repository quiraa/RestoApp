import 'package:json_annotation/json_annotation.dart';

part 'review_body.g.dart';

@JsonSerializable()
class ReviewBody {
  final String? id;
  final String? name;
  final String? review;

  const ReviewBody({this.id, this.name, this.review});

  factory ReviewBody.fromJson(Map<String, dynamic> json) =>
      _$ReviewBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewBodyToJson(this);
}
