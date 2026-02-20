// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/feature/auth/view/signin_view.dart';
import 'package:velozaje/feature/auth/widget/auth_background.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/res/common_text_field_with_title.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController fullNameController = TextEditingController();

  ValueNotifier<bool> isPasswordVisible = ValueNotifier(true);

  ValueNotifier<bool> isTermsAccept = ValueNotifier(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                            AppLocalizations.of(context)!.create_account,
                            size: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),

                        SizedBox(height: 30.h),

                        CommonTextfieldWithTitle(
                          AppLocalizations.of(context)!.full_name,
                          fullNameController,
                          hintText: AppLocalizations.of(
                            context,
                          )!.enter_your_full_name,
                        ),
                        SizedBox(height: 16.h),

                        /// Email field
                        CommonTextfieldWithTitle(
                          AppLocalizations.of(context)!.email,
                          emailController,
                          hintText: AppLocalizations.of(
                            context,
                          )!.enter_your_email,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 16.h),

                        /// Password field
                        ValueListenableBuilder(
                          valueListenable: isPasswordVisible,
                          builder: (context, value, child) {
                            return CommonTextfieldWithTitle(
                              AppLocalizations.of(context)!.password,
                              passwordController,
                              hintText: AppLocalizations.of(
                                context,
                              )!.enter_your_password,
                              issuffixIconVisible: true,
                              isPasswordVisible: value,
                              changePasswordVisibility: () {
                                isPasswordVisible.value =
                                    !isPasswordVisible.value;
                              },
                            );
                          },
                        ),

                        Row(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: isTermsAccept,
                              builder: (context, value, child) {
                                return Checkbox(
                                  value: value,
                                  onChanged: (value) {
                                    isTermsAccept.value = value!;
                                  },
                                );
                              },
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppLocalizations.of(
                                        context,
                                      )!.i_accept_the,
                                      style: TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    TextSpan(
                                      text: AppLocalizations.of(
                                        context,
                                      )!.terms_conditions,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10.h),

                        /// Login button
                        ValueListenableBuilder(
                          valueListenable: ref
                              .watch(authControllerProvider)
                              .isLoading,
                          builder: (context, value, child) {
                            return CommonButton(
                              AppLocalizations.of(context)!.register,
                              isLoading: value,
                              onTap: () {
                                ref
                                    .read(authControllerProvider)
                                    .signup(
                                      name: fullNameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      termsAndConditions: isTermsAccept.value,
                                    );
                              },
                            );
                          },
                        ),

                        SizedBox(height: 16.h),

                        /// Register text
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(
                                    context,
                                  )!.already_have_an_account,
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                TextSpan(text: "  "),
                                TextSpan(
                                  text: AppLocalizations.of(context)!.login,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return SignInPage();
                                          },
                                        ),
                                      );
                                    },
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
