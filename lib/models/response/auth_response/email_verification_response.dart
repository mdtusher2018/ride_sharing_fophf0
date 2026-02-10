class EmailVerificationResponse {
  bool success;
  String message;
  String token;

  EmailVerificationResponse({
    required this.success,
    required this.message,
    required this.token,
  });

  factory EmailVerificationResponse.fromJson(Map<String, dynamic> json) {
    return EmailVerificationResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      token: json['data']?['token'] ?? "",
    );
  }
}
