class SignUpModel {
  bool success;
  String message;
  String token;

  SignUpModel({
    required this.success,
    required this.message,
    required this.token,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      token: json['data']?['token'] ?? "",
    );
  }
}
