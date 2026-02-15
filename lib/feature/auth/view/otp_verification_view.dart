// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/services/providers.dart';
import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/feature/auth/widget/auth_background.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_otp_field.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/core/utils/helper.dart';

class OtpVerificationPage extends ConsumerStatefulWidget {
  const OtpVerificationPage({
    super.key,
    required this.email,
    required this.puspose,
  });
  final String email;
  final OTPVerificationPurpose puspose;

  @override
  ConsumerState<OtpVerificationPage> createState() =>
      _OtpVerificationPageState();
}

class _OtpVerificationPageState extends ConsumerState<OtpVerificationPage>
    with WidgetsBindingObserver {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkClipboard(_controllers, _focusNodes);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // listen to lifecycle
    checkClipboard(_controllers, _focusNodes);
  }

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
                            AppLocalizations.of(context)!.verification_code,
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
                              )!.we_ve_sent_a_4_digit_otp_code_to_your_email_address_please_enter_it_below_to_verify_and_continue_with_password_reset,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        SizedBox(height: 30.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return CommonOtpField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              onChanged: (value) => _onChanged(value, index),
                            );
                          }),
                        ),

                        SizedBox(height: 30.h),

                        /// Login button
                        ValueListenableBuilder(
                          valueListenable: ref
                              .watch(authControllerProvider)
                              .isLoading,
                          builder: (context, value, child) {
                            return CommonButton(
                              AppLocalizations.of(context)!.enter,
                              isLoading: value,
                              onTap: () {
                                ref
                                    .read(authControllerProvider)
                                    .verifyOTP(
                                      email: widget.email,
                                      purpose: widget.puspose,
                                      otp: _controllers.map((e) {
                                        return e.text;
                                      }).join(),
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
