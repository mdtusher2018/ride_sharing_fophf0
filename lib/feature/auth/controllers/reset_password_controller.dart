import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/services/providers.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/core/utils/extention.dart';
import 'package:velozaje/core/utils/global_keys.dart';
import 'package:velozaje/feature/auth/view/signin_view.dart';

final resetPasswordControllerProvider = Provider((ref) {
  return ResetPasswordController(ref.read(apiServiceProvider));
});

class ResetPasswordController extends BaseNotifier {
  final IApiService _apiService;

  ResetPasswordController(this._apiService) : super(false);

  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    safeCall(
      task: () async {
        final response = await _apiService.post(ApiEndpoints.resetPassword, {
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
    );
  }
}
