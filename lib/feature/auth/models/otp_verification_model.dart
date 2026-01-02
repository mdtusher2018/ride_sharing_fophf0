class OTPVerificationModel {
  bool success;
  String message;
  String token;

  OTPVerificationModel({
    required this.success,
    required this.message,
    required this.token,
  });

  factory OTPVerificationModel.fromJson(Map<String, dynamic> json) {
    return OTPVerificationModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      token: json['data']?['token'] ?? "",
    );
  }
}
