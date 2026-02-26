import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:velozaje/core/services/api/api_exception.dart';
import 'package:velozaje/core/utils/extention.dart';
import 'package:velozaje/core/utils/constants.dart';
import 'package:velozaje/core/utils/app_colors.dart';

abstract class BaseNotifier<T> extends StateNotifier<T> {
  BaseNotifier(super.state);

  // Reactive fields for UI listening
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  Future<R?> safeCall<R>({
    required Future<R> Function() task,
    String? successMessage,
    bool showErrorSnack = true,
    bool showSuccessSnack = false,
    void Function()? onStart,
    void Function()? onComplete,
    Function(int, String)? handleErrorExplicitly,
    bool showLoading = true,
  }) async {
    try {
      onStart?.call();
      if (showLoading) isLoading.value = true;
      errorMessage.value = null;

      final result = await task();

      if (showSuccessSnack && successMessage != null) {
        final context = navigatorKey.currentContext;
        if (context != null) {
          context.showCommonSnackbar(
            title: "Success",
            message: successMessage,
            backgroundColor: AppColors.success,
          );
        }
      }

      return result;
    } catch (e, stack) {
      debugPrint("❌ Exception: $e\n$stack");
      errorMessage.value = e.toString();
      if (handleErrorExplicitly != null && e is ApiException) {
        handleErrorExplicitly(e.statusCode, e.message);
        return null;
      }
      if (showErrorSnack) {
        final context = navigatorKey.currentContext;
        if (context != null) {
          context.showCommonSnackbar(
            title: "Error",
            message: errorMessage.value ?? "Something went wrong",
            backgroundColor: AppColors.error,
          );
        }
      }

      return null;
    } finally {
      isLoading.value = false;
      onComplete?.call();
    }
  }
}
