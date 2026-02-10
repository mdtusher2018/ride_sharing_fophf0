import 'package:velozaje/models/user_model.dart';
import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class UserProfileResponse {
  final bool success;
  final String message;
  final UserModel? data;

  UserProfileResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: json['data'] != null ? UserModel.fromJson(json['data']) : null,
    );
  }
}
