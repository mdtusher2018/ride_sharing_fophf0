import 'package:velozaje/models/vehicale_model.dart';

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
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? Vehicle.fromJson(json['data'])
          : Vehicle.empty(),
    );
  }
}
