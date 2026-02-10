class OTPVerificationResponse {
  bool success;
  String message;
  String token;

  OTPVerificationResponse({
    required this.success,
    required this.message,
    required this.token,
  });

  factory OTPVerificationResponse.fromJson(Map<String, dynamic> json) {
    return OTPVerificationResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      token: json['data']?['token'] ?? "",
    );
  }
}
