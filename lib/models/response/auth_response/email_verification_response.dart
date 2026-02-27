import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class EmailVerificationResponse {
  final bool success;
  final String message;
  final String token;

  EmailVerificationResponse({
    required this.success,
    required this.message,
    required this.token,
  });

  factory EmailVerificationResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return EmailVerificationResponse.empty();
    }

    return EmailVerificationResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      token: JsonHelper.stringVal(
        (json['data'] is Map<String, dynamic>) ? json['data']['token'] : null,
      ),
    );
  }

  factory EmailVerificationResponse.empty() =>
      EmailVerificationResponse(success: false, message: '', token: '');
}
