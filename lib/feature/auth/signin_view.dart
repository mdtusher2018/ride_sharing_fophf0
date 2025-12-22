// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/auth/forget_password_view.dart';
import 'package:velozaje/feature/auth/signup_view.dart';
import 'package:velozaje/feature/auth/widget/auth_backend.dart';
import 'package:velozaje/feature/root_view.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/res/common_text_field_with_title.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                            'Welcome Back',
                            size: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),

                        SizedBox(height: 30.h),

                        /// Email field
                        CommonTextfieldWithTitle(
                          'Email',
                          emailController,
                          hintText: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 16.h),

                        /// Password field
                        CommonTextfieldWithTitle(
                          'Password',
                          passwordController,
                          hintText: 'Enter your password',
                          issuffixIconVisible: true,
                          isPasswordVisible: isPasswordVisible,
                          changePasswordVisibility: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ForgetPasswordPage();
                                    },
                                  ),
                                );
                              },
                              child: CommonText(
                                'Forgot Password?',
                                size: 12,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10.h),

                        /// Login button
                        CommonButton(
                          "Log in",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return RootPage();
                                },
                              ),
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
                                  text: "You don't have an account? ",
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Register',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return SignUpPage();
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
