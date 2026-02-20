// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/feature/auth/widget/auth_background.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/res/common_text_field_with_title.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80),
            CommonImage(path: "assest/image/logo.png", width: 200),
            AuthBackground(
              backgroundColor: Color(0xFFE6E6E6),
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0),

                child: AuthBackground(
                  curve: 800,
                  backgroundColor: Color(0xFFF4F4F4),
                  child: Padding(
                    padding: EdgeInsets.only(right: 24, left: 24, top: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: CommonText(
                            AppLocalizations.of(context)!.reset_your_password,
                            size: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommonText(
                              AppLocalizations.of(
                                context,
                              )!.enter_your_registered_email_address_below_we_ll_send_you_a_one_time_password_otp_to_reset_your_password_securely,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        SizedBox(height: 30.h),

                        CommonTextfieldWithTitle(
                          AppLocalizations.of(context)!.email,
                          emailController,
                          hintText: AppLocalizations.of(
                            context,
                          )!.enter_your_email,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 16.h),

                        SizedBox(height: 10.h),

                        Consumer(
                          builder: (context, ref, _) {
                            final state = ref.watch(authControllerProvider);

                            return ValueListenableBuilder(
                              valueListenable: state.isLoading,
                              builder: (context, value, child) {
                                return CommonButton(
                                  AppLocalizations.of(context)!.send_otp_code,
                                  isLoading: value,
                                  onTap: () async {
                                    await state.sendOtp(
                                      email: emailController.text,
                                      purpose:
                                          OTPVerificationPurpose.forgotPassword,
                                    );
                                  },
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
