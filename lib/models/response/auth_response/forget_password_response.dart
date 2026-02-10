class ForgetPasswordResponse {
  bool success;
  String message;
  String token;

  ForgetPasswordResponse({
    required this.success,
    required this.message,
    required this.token,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      token: json['data']?['token'] ?? "",
    );
  }
}
