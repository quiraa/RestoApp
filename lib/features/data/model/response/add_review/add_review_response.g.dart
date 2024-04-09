// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReviewResponse _$AddReviewResponseFromJson(Map<String, dynamic> json) =>
    AddReviewResponse(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      customerReviews: (json['customerReviews'] as List<dynamic>?)
          ?.map(
              (e) => CustomerReviewResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddReviewResponseToJson(AddReviewResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'customerReviews': instance.customerReviews,
    };
