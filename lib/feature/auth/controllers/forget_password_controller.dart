import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/services/localstorage/i_local_storage_service.dart';
import 'package:velozaje/core/services/localstorage/storage_key.dart';
import 'package:velozaje/core/services/providers.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/core/utils/extention.dart';
import 'package:velozaje/core/utils/global_keys.dart';
import 'package:velozaje/feature/auth/models/forget_password_model.dart';
import 'package:velozaje/feature/auth/view/otp_verification_view.dart';

final forgetVerificationProvider = Provider((ref) {
  return ForgetPasswordController(
    apiService: ref.read(apiServiceProvider),
    localStorageService: ref.read(localStorageProvider),
  );
});

class ForgetPasswordController extends BaseNotifier {
  final IApiService apiService;
  final ILocalStorageService localStorageService;

  ForgetPasswordController({
    required this.apiService,
    required this.localStorageService,
  }) : super(false);

  Future<void> forgetVerification({required String email}) async {
    safeCall(
      task: () async {
        final response = await apiService.post(ApiEndpoints.forgetPassword, {
          "email": email,

          "purpose": "passwordReset",
        });
        if (response['success'] ?? false) {
          final user = ForgetPasswordModel.fromJson(response);

          await localStorageService.saveString(StorageKey.token, user.token);

          navigatorKey.currentContext?.navigateTo(
            OtpVerificationPage(email: email),
          );
        } else {
          throw Exception(response['message'] ?? 'Failed to send OTP failed');
        }
      },
    );
  }
}
