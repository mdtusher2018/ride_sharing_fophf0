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

  factory ReviewModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('ReviewModel JSON cannot be null');
    }

    return ReviewModel(
      id: JsonHelper.stringVal(json['_id']),
      booking: JsonHelper.stringVal(json['booking']),
      trip: JsonHelper.stringVal(json['trip']),
      driver: JsonHelper.stringVal(json['driver']),
      passengerImage: JsonHelper.stringVal(json['passengerImage']),
      passengerName: _parsePassengerName(json['passenger']),
      rating: JsonHelper.intVal(json['rating']),
      review: JsonHelper.stringVal(json['review']),
      createdAt: JsonHelper.parseDate(json['createdAt']),
      updatedAt: JsonHelper.parseDate(json['updatedAt']),
    );
  }

  static String _parsePassengerName(dynamic passenger) {
    if (passenger is Map<String, dynamic>) {
      return JsonHelper.stringVal(passenger['fullName']);
    }
    return '';
  }
}
