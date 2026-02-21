import 'package:velozaje/models/pagenation_meta_model.dart';
import 'package:velozaje/models/review_model.dart';

class DriverReviewsResponse {
  final bool success;
  final String message;
  final DriverReviewsData data;

  DriverReviewsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DriverReviewsResponse.fromJson(Map<String, dynamic> json) {
    return DriverReviewsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DriverReviewsData.fromJson(json['data'] ?? {}),
    );
  }
}

class DriverReviewsData {
  final List<ReviewModel> reviews;
  final PaginationMetaModel pagination;

  DriverReviewsData({required this.reviews, required this.pagination});

  factory DriverReviewsData.fromJson(Map<String, dynamic> json) {
    return DriverReviewsData(
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map((e) => ReviewModel.fromJson(e))
              .toList() ??
          [],
      pagination: PaginationMetaModel.fromJson(json['pagination'] ?? {}),
    );
  }
}
