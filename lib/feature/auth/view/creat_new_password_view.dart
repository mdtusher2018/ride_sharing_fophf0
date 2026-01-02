import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/feature/auth/controllers/reset_password_controller.dart';
import 'package:velozaje/feature/auth/widget/auth_backend.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/res/common_text_field_with_title.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({super.key});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isNewPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80.h),
            CommonImage(path: "assest/image/logo.png", width: 200.w),
            AuthBackground(
              backgroundColor: const Color(0xFFE6E6E6),
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: AuthBackground(
                  curve: 800,
                  backgroundColor: const Color(0xFFF4F4F4),
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 24.w,
                      left: 24.w,
                      top: 100.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: CommonText(
                            AppLocalizations.of(context)!.create_new_password,
                            size: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 30.h),

                        CommonTextfieldWithTitle(
                          AppLocalizations.of(context)!.new_password,
                          newPasswordController,
                          hintText: AppLocalizations.of(
                            context,
                          )!.enter_your_password,
                          issuffixIconVisible: true,
                          isPasswordVisible: isNewPasswordVisible,
                          changePasswordVisibility: () {
                            setState(() {
                              isNewPasswordVisible = !isNewPasswordVisible;
                            });
                          },
                        ),

                        SizedBox(height: 16.h),
                        CommonTextfieldWithTitle(
                          AppLocalizations.of(context)!.confirm_password,
                          newPasswordController,
                          hintText: AppLocalizations.of(
                            context,
                          )!.enter_your_confirm_password,
                          issuffixIconVisible: true,
                          isPasswordVisible: isConfirmPasswordVisible,
                          changePasswordVisibility: () {
                            setState(() {
                              isConfirmPasswordVisible =
                                  !isConfirmPasswordVisible;
                            });
                          },
                        ),

                        SizedBox(height: 30.h),

                        Consumer(
                          builder: (context, ref, _) {
                            return ValueListenableBuilder(
                              valueListenable: ref
                                  .watch(resetPasswordControllerProvider)
                                  .isLoading,
                              builder: (context, value, child) {
                                return CommonButton(
                                  AppLocalizations.of(context)!.update_password,
                                  isLoading: value,
                                  onTap: () {},
                                );
                              },
                            );
                          },
                        ),

                        SizedBox(height: 80.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
