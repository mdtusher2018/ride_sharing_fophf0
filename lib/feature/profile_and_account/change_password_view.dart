import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_text_field_with_title.dart';
import 'package:velozaje/core/utils/app_colors.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  // Controllers for text fields
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Password visibility toggles
  bool isCurrentPasswordVisible = true;
  bool isNewPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  // Function to handle password update logic
  void _updatePassword() {
    ref
        .read(authControllerProvider)
        .changePassword(
          oldPassword: currentPasswordController.text,
          newPassword: newPasswordController.text,
          confirmPassword: confirmPasswordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        title: AppLocalizations.of(context)!.change_password,
        backgroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: ListView(
          children: [
            // Current Password Field
            CommonTextfieldWithTitle(
              '',
              currentPasswordController,
              hintText: AppLocalizations.of(
                context,
              )!.enter_your_current_password,

              issuffixIconVisible: true,
              isPasswordVisible: isCurrentPasswordVisible,
              changePasswordVisibility: () {
                setState(() {
                  isCurrentPasswordVisible = !isCurrentPasswordVisible;
                });
              },
            ),

            // New Password Field
            CommonTextfieldWithTitle(
              '',
              newPasswordController,
              hintText: AppLocalizations.of(context)!.enter_your_new_password,
              issuffixIconVisible: true,
              isPasswordVisible: isNewPasswordVisible,
              changePasswordVisibility: () {
                setState(() {
                  isNewPasswordVisible = !isNewPasswordVisible;
                });
              },
            ),

            // Confirm New Password Field
            CommonTextfieldWithTitle(
              "",
              confirmPasswordController,
              hintText: AppLocalizations.of(
                context,
              )!.re_enter_your_new_password,
              issuffixIconVisible: true,
              isPasswordVisible: isConfirmPasswordVisible,
              changePasswordVisibility: () {
                setState(() {
                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                });
              },
            ),
            SizedBox(height: 30.h),

            // Update Button
            ValueListenableBuilder(
              valueListenable: ref.watch(authControllerProvider).isLoading,
              builder: (_, isLoading, _) {
                return CommonButton(
                  AppLocalizations.of(context)!.update,
                  isLoading: isLoading,
                  onTap:
                      _updatePassword, // Call _updatePassword method on button tap
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
