// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                            'Create New Password',
                            size: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 30.h),

                        /// New Password field
                        CommonTextfieldWithTitle(
                          'New Password',
                          newPasswordController,
                          hintText: 'Enter your password',
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
                          'Confirm Password',
                          newPasswordController,
                          hintText: 'Enter your confirm password',
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

                        /// Send OTP button
                        CommonButton(
                          "Update Password",
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       return const EmailVerificationPage();
                            //     },
                            //   ),
                            // );
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
