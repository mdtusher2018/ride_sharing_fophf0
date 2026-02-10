class SignUpResponse {
  bool success;
  String message;
  String token;

  SignUpResponse({
    required this.success,
    required this.message,
    required this.token,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      token: json['data']?['token'] ?? "",
    );
  }
}
