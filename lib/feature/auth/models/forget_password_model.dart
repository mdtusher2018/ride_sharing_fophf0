class ForgetPasswordModel {
  bool success;
  String message;
  String token;

  ForgetPasswordModel({
    required this.success,
    required this.message,
    required this.token,
  });

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      token: json['data']?['token'] ?? "",
    );
  }
}
