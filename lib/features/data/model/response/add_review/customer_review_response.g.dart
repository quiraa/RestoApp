// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerReviewResponse _$CustomerReviewResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerReviewResponse(
      name: json['name'] as String?,
      review: json['review'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$CustomerReviewResponseToJson(
        CustomerReviewResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'review': instance.review,
      'date': instance.date,
    };
