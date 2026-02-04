import 'package:velozaje/feature/vehicale/model/vehicale_model.dart';

class MyVehicleResponse {
  final bool success;
  final String message;
  final Vehicle data;

  MyVehicleResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MyVehicleResponse.fromJson(Map<String, dynamic> json) {
    return MyVehicleResponse(
      success: json['success'],
      message: json['message'],
      data: Vehicle.fromJson(json['data']),
    );
  }
}
