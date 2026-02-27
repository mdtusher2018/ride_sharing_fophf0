import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class OTPVerificationResponse {
  final bool success;
  final String message;
  final String token;

  OTPVerificationResponse({
    required this.success,
    required this.message,
    required this.token,
  });

  factory OTPVerificationResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return OTPVerificationResponse.empty();
    }

    final data = json['data'];

    return OTPVerificationResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      token: JsonHelper.stringVal(
        data is Map<String, dynamic> ? data['token'] : null,
      ),
    );
  }

  factory OTPVerificationResponse.empty() =>
      OTPVerificationResponse(success: false, message: '', token: '');
}
