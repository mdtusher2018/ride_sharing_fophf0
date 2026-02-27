import 'package:velozaje/core/utils/api_data_praser_helper.dart';
import 'package:velozaje/models/save_location_model.dart';

class AddSavedLocationResponse {
  final bool success;
  final String message;
  final SavedLocation data;

  AddSavedLocationResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddSavedLocationResponse.fromJson(Map<String, dynamic> json) {
    return AddSavedLocationResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: SavedLocation.fromJson(json['data']['savedPlace']),
    );
  }
}
