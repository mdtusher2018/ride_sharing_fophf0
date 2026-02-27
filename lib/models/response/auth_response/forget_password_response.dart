import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class ForgetPasswordResponse {
  final bool success;
  final String message;
  final String token;

  ForgetPasswordResponse({
    required this.success,
    required this.message,
    required this.token,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ForgetPasswordResponse.empty();
    }

    final data = json['data'];

    return ForgetPasswordResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      token: JsonHelper.stringVal(
        data is Map<String, dynamic> ? data['token'] : null,
      ),
    );
  }

  factory ForgetPasswordResponse.empty() =>
      ForgetPasswordResponse(success: false, message: '', token: '');
}
