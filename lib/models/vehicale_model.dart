import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class Vehicle {
  final String id;
  final String user;
  final String vehicleType;
  final String registration;
  final int year;
  final String brand;
  final String vehicleModel;
  final String licensePlateNumber;
  final List<String> vehicleImages;
  final String status;
  final DateTime submittedAt;
  final DateTime createdAt;

  Vehicle({
    required this.id,
    required this.user,
    required this.vehicleType,
    required this.registration,
    required this.year,
    required this.brand,
    required this.vehicleModel,
    required this.licensePlateNumber,
    required this.vehicleImages,
    required this.status,
    required this.submittedAt,
    required this.createdAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('Vehicle JSON cannot be null');
    }

    return Vehicle(
      id: JsonHelper.stringVal(json['_id']),
      user: JsonHelper.stringVal(json['user']),
      vehicleType: JsonHelper.stringVal(json['vehicleType']),
      registration: JsonHelper.stringVal(json['registration']),
      year: JsonHelper.intVal(json['year']),
      brand: JsonHelper.stringVal(json['brand']),
      vehicleModel: JsonHelper.stringVal(json['vehicleModel']),
      licensePlateNumber: JsonHelper.stringVal(json['licensePlateNumber']),
      vehicleImages: _parseImages(json['vehicleImages']),
      status: JsonHelper.stringVal(json['status']),
      submittedAt: JsonHelper.parseDate(json['submittedAt']) ?? DateTime.now(),
      createdAt: JsonHelper.parseDate(json['createdAt']) ?? DateTime.now(),
    );
  }

  static List<String> _parseImages(dynamic value) {
    if (value is List) {
      return value
          .map((e) => JsonHelper.stringVal(e))
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return [];
  }
}
