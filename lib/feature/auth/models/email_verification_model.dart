class EmailVerificationModel {
  bool success;
  String message;
  String token;

  EmailVerificationModel({
    required this.success,
    required this.message,
    required this.token,
  });

  factory EmailVerificationModel.fromJson(Map<String, dynamic> json) {
    return EmailVerificationModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      token: json['data']?['token'] ?? "",
    );
  }
}
