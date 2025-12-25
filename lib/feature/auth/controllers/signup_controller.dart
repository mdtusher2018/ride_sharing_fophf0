import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/services/localstorage/i_local_storage_service.dart';
import 'package:velozaje/core/services/localstorage/storage_key.dart';
import 'package:velozaje/core/services/providers.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/core/utils/extention.dart';
import 'package:velozaje/core/utils/global_keys.dart';
import 'package:velozaje/feature/auth/models/signup_model.dart';
import 'package:velozaje/feature/auth/view/email_verification_view.dart';

final Provider<SignupController> signupControllerProvider = Provider((ref) {
  return SignupController(
    apiService: ref.read(apiServiceProvider),
    localStorageService: ref.read(localStorageProvider),
  );
});

class SignupController extends BaseNotifier {
  final IApiService apiService;
  final ILocalStorageService localStorageService;
  SignupController({
    required this.apiService,
    required this.localStorageService,
  }) : super(false);

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
          final user = SignUpModel.fromJson(response);

          await localStorageService.saveString(StorageKey.token, user.token);

          navigatorKey.currentContext?.navigateTo(EmailVerificationPage());
        } else {
          throw Exception(response['message'] ?? 'Failed to send OTP failed');
        }
      },
      successMessage: "OTP sent",
      showSuccessSnack: true,
    );
  }
}
