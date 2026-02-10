class SignInResponse {
  bool success;
  String message;
  String token;

  SignInResponse({
    required this.success,
    required this.message,
    required this.token,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      token: json['data']?['token'] ?? "",
    );
  }
}
