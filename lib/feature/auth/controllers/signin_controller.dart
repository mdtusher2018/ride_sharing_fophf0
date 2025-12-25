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
import 'package:velozaje/feature/auth/models/signin_model.dart';
import 'package:velozaje/feature/root_view.dart';

final Provider<SigninController> signInControllerProvider =
    Provider<SigninController>((ref) {
      final IApiService apiService = ref.read(apiServiceProvider);
      final ILocalStorageService localStorageService = ref.read(
        localStorageProvider,
      );
      return SigninController(
        apiService: apiService,
        localStorageService: localStorageService,
      );
    });

class SigninController extends BaseNotifier {
  final IApiService apiService;
  final ILocalStorageService localStorageService;
  SigninController({
    required this.apiService,
    required this.localStorageService,
  }) : super(false);

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
          final user = SignInModel.fromJson(response);

          await localStorageService.saveString(StorageKey.token, user.token);

          // await localStorageService.saveLogin(email, password);

          navigatorKey.currentContext?.navigateTo(RootPage());
        } else {
          throw Exception(response['message'] ?? 'Login failed');
        }
      },
      successMessage: "login sucessfully",
      showSuccessSnack: true,
    );
  }
}
