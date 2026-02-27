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

  factory UserProfileResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return UserProfileResponse.empty();
    }

    final dataJson = json['data'];
    final userData = (dataJson is Map<String, dynamic>)
        ? UserModel.fromJson(dataJson)
        : null;

    return UserProfileResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: userData,
    );
  }

  factory UserProfileResponse.empty() =>
      UserProfileResponse(success: false, message: '', data: null);
}
