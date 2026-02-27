import 'package:velozaje/core/utils/api_data_praser_helper.dart';
import 'package:velozaje/models/vehicale_model.dart';

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
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: Vehicle.fromJson(json['data']?['vehicle']),
    );
  }
}
