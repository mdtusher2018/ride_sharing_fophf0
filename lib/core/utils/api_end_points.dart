class ApiEndpoints {
  static const String baseUrl = 'http://10.10.10.70:3032/api/v1/';
  static const String baseImageUrl = 'http://10.10.10.70:3032';

  //authentication
  static const String signin = "auth/login";
  static const String signup = "auth/signup";
  static const String verifyOTP = "auth/verify-otp";
  static const String forgetPassword = "auth/token";
  static const String resetPassword = "auth/reset-password";
}
