// session_reset.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velozaje/core/services/providers.dart';

void resetSession(WidgetRef ref) {
  // 🔁 Authentication
  // ref.invalidate(signInControllerProvider);
  // ref.invalidate(signUpControllerProvider);
  // ref.invalidate(afterSignUpOtpControllerProvider);
  // ref.invalidate(forgetPasswordControllerProvider);
  // ref.invalidate(forgotPasswordOtpControllerProvider);
  // ref.invalidate(createNewPasswordControllerProvider);

  // 🔁 Core Services
  ref.invalidate(apiServiceProvider);
  ref.invalidate(apiClientProvider);
  ref.invalidate(localStorageProvider);

  // ⚠️ Not directly invalidating family providers like:
  // - postLikeDeleteControllerProvider
  // - postDetailsProvider
  // These require specific arguments. You can handle them explicitly if needed, e.g.:
  // ref.invalidate(postDetailsProvider('post-id-here'));
}
