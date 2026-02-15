import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/services/localstorage/i_local_storage_service.dart';
import 'package:velozaje/core/services/localstorage/storage_key.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/core/utils/extention.dart';
import 'package:velozaje/core/utils/global_keys.dart';
import 'package:velozaje/feature/auth/view/confirm_details_view.dart';
import 'package:velozaje/models/response/auth_response/forget_password_response.dart';
import 'package:velozaje/feature/auth/view/otp_verification_view.dart';
import 'package:velozaje/models/response/auth_response/otp_verification_response.dart';
import 'package:velozaje/feature/auth/view/creat_new_password_view.dart';
import 'package:velozaje/feature/auth/view/signin_view.dart';
import 'dart:developer';
import 'package:velozaje/models/response/auth_response/signin_response.dart';
import 'package:velozaje/feature/root_view.dart';
import 'package:velozaje/models/response/auth_response/signup_response.dart';

class AuthController extends BaseNotifier {
  final IApiService apiService;
  final ILocalStorageService localStorageService;

  AuthController({required this.apiService, required this.localStorageService})
    : super(false);

  Future<void> sendOtp({
    required String email,
    required OTPVerificationPurpose purpose,
  }) async {
    safeCall(
      task: () async {
        final response = await apiService.post(ApiEndpoints.forgetPassword, {
          "email": email,
          "purpose": (purpose == OTPVerificationPurpose.emailVerify)
              ? "emailVerification"
              : "passwordReset",
        });
        if (response['success'] ?? false) {
          final user = ForgetPasswordResponse.fromJson(response);

          await localStorageService.saveString(
            StorageKey.accessToken,
            user.token,
          );

          navigatorKey.currentContext?.navigateTo(
            OtpVerificationPage(email: email, puspose: purpose),
          );
        } else {
          throw Exception(response['message'] ?? 'Failed to send OTP failed');
        }
      },
    );
  }

  Future<void> verifyOTP({
    required String email,
    required String otp,
    required OTPVerificationPurpose purpose,
  }) async {
    safeCall(
      task: () async {
        final response = await apiService.post(ApiEndpoints.verifyOTP, {
          "email": email,
          "otp": otp,
          "purpose": (purpose == OTPVerificationPurpose.emailVerify)
              ? "emailVerification"
              : "passwordReset",
        });
        if (response['success'] ?? false) {
          final user = OTPVerificationResponse.fromJson(response);

          await localStorageService.saveString(
            StorageKey.accessToken,
            user.token,
          );

          navigatorKey.currentContext?.navigateTo(
            purpose == OTPVerificationPurpose.emailVerify
                ? ConfirmDetailsPage()
                : CreateNewPasswordPage(email: email),
          );
        } else {
          throw Exception(response['message'] ?? 'Failed to send OTP failed');
        }
      },
    );
  }

  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    safeCall(
      task: () async {
        final response = await apiService.post(ApiEndpoints.resetPassword, {
          "email": email,
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        });
        if (response['success'] ?? false) {
          navigatorKey.currentContext?.navigateTo(SignInPage());
        } else {
          throw Exception(response['message'] ?? 'Failed to reset password');
        }
      },
      successMessage: "You can now login with your new password",
      showSuccessSnack: true,
    );
  }

  /// Sign in API call
  Future<void> signIn({required String email, required String password}) async {
    safeCall(
      task: () async {
        log("==========>>>>>>> $email");

        final response = await apiService.post(ApiEndpoints.signin, {
          'email': email,
          'password': password,
        });

        if (response['success'] ?? false) {
          final user = SignInResponse.fromJson(response);

          await localStorageService.saveString(
            StorageKey.accessToken,
            user.token,
          );

          // await localStorageService.saveLogin(email, password);

          navigatorKey.currentContext?.navigateTo(RootPage());
        } else {
          throw Exception(response['message'] ?? 'Login failed');
        }
      },

      showSuccessSnack: true,
    );
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required bool termsAndConditions,
  }) async {
    safeCall(
      task: () async {
        log("==========>>>>>>> $email");

        final response = await apiService.post(ApiEndpoints.signup, {
          'fullName': name,
          'email': email,
          'password': password,
        });

        if (response['success'] ?? false) {
          final user = SignUpResponse.fromJson(response);

          await localStorageService.saveString(
            StorageKey.accessToken,
            user.token,
          );

          navigatorKey.currentContext?.navigateTo(
            OtpVerificationPage(
              email: email,
              puspose: OTPVerificationPurpose.emailVerify,
            ),
          );
        } else {
          throw Exception(response['message'] ?? 'Failed to send OTP failed');
        }
      },
    );
  }
}
