import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class ReviewModel {
  final String id;
  final String booking;
  final String trip;
  final String driver;
  final String passengerImage;
  final String passengerName;
  final int rating;
  final String review;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReviewModel({
    required this.id,
    required this.booking,
    required this.trip,
    required this.driver,
    required this.passengerImage,
    required this.passengerName,
    required this.rating,
    required this.review,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'] ?? '',
      booking: json['booking'] ?? '',
      trip: json['trip'] ?? '',
      driver: json['driver'] ?? '',
      passengerImage: json['passengerImage'] ?? '',
      passengerName: JsonHelper.stringVal(json['passenger']?['fullName']),
      rating: json['rating'] ?? 0,
      review: json['review'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}
