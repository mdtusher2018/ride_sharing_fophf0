import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class SignInResponse {
  final bool success;
  final String message;
  final String token;

  SignInResponse({
    required this.success,
    required this.message,
    required this.token,
  });

  factory SignInResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SignInResponse.empty();
    }

    final data = json['data'];

    return SignInResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      token: JsonHelper.stringVal(
        data is Map<String, dynamic> ? data['token'] : null,
      ),
    );
  }

  factory SignInResponse.empty() =>
      SignInResponse(success: false, message: '', token: '');
}
