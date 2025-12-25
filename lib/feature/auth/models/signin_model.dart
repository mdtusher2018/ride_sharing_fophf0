class SignInModel {
  bool success;
  String message;
  String token;

  SignInModel({
    required this.success,
    required this.message,
    required this.token,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      token: json['data']?['token'] ?? "",
    );
  }
}
