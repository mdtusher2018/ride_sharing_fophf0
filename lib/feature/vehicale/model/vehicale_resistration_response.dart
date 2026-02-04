import 'package:velozaje/feature/vehicale/model/vehicale_model.dart';

class VehicleResponse {
  final bool success;
  final String message;
  final Vehicle data;

  VehicleResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory VehicleResponse.fromJson(Map<String, dynamic> json) {
    return VehicleResponse(
      success: json['success'],
      message: json['message'],
      data: Vehicle.fromJson(json['data']?['vehicle']),
    );
  }
}
