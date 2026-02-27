import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class SignUpResponse {
  final bool success;
  final String message;
  final String token;

  SignUpResponse({
    required this.success,
    required this.message,
    required this.token,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SignUpResponse.empty();
    }

    final data = json['data'];

    return SignUpResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      token: JsonHelper.stringVal(
        data is Map<String, dynamic> ? data['token'] : null,
      ),
    );
  }

  factory SignUpResponse.empty() =>
      SignUpResponse(success: false, message: '', token: '');
}
