import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/root_view.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_otp_field.dart';
import 'package:velozaje/res/common_text.dart';

class ReferalPage extends StatelessWidget {
  ReferalPage({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
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
            child: CommonText(
              "Skip >>",
              size: 14,
              isBold: true,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              Container(
                constraints: BoxConstraints(maxWidth: 250.w),
                child: CommonImage(path: "assest/image/referal.png"),
              ),
              SizedBox(height: 30.h),
              CommonText("Referral Code", size: 21, isBold: true),
              SizedBox(height: 30.h),
              CommonText(
                " Have a code? Enter it to unlock 0% commission on your first trip as a driver.",
                size: 14,
                textAlign: TextAlign.center,
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
              SizedBox(height: 50.h),

              /// Login button
              CommonButton(
                "Submite",
                onTap: () {
                  _showSuccessDialog(context);
                },
              ),

              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Icon(Icons.cancel, color: AppColors.primary)],
                ),
                SizedBox(height: 16.h),

                /// Title
                CommonText("Documents Sent Successfully!", size: 18),

                SizedBox(height: 8.h),

                /// Subtitle / message
                CommonText(
                  "We will notify you once your documents are verified.",
                  textAlign: TextAlign.center,
                  size: 14,
                ),

                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
