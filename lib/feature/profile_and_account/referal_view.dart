import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velozaje/res/common_text.dart';

class ReferralsPage extends StatelessWidget {
  const ReferralsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Referrals"),
      backgroundColor: AppColors.mainbg,
      body: Padding(
        padding: EdgeInsets.all(16.0.w), // Scalable padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CommonImage(
                path: "assest/image/gift-ezgif.com-gif-maker 1.png",
                height: 120,
                width: 120,
              ),
            ),

            SizedBox(height: 16.h), // Scalable height
            Center(
              child: CommonText(
                '100% Commission Free',
                size: 18.sp, // Scalable font size
                color: AppColors.primary,
                isBold: true,
              ),
            ),
            SizedBox(height: 8.h), // Scalable height
            Center(child: CommonText('On your next published trip', size: 14)),
            SizedBox(height: 24.h), // Scalable height
            _buildReferralStep(
              'Share your code',
              'Send your unique code to friends.',
              Icons.share_outlined,
            ),
            _stepLine(),
            _buildReferralStep(
              'Friend joins',
              'Your friend records it when signing up.',
              Iconsax.profile_2user_outline,
            ),
            _stepLine(),
            _buildReferralStep(
              'You both win',
              'Get discounts on your trips automatically.',

              Iconsax.ticket_2_outline,
            ),
            SizedBox(height: 24.h), // Scalable height

            SizedBox(height: 8.h), // Scalable height
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 16.w,
              ), // Scalable padding
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.w,
                  color: AppColors.primary,
                ), // Scalable border width
                borderRadius: BorderRadius.circular(
                  8.r,
                ), // Scalable border radius
              ),
              child: Center(
                child: Column(
                  spacing: 4.h,
                  children: [
                    CommonText("Your Code"),
                    CommonText(
                      '4 5 b 7',
                      size: 24.sp, // Scalable font size
                      color: AppColors.primary,
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),

            CommonButton(
              "Share Code",
              iconWidget: Padding(
                padding: EdgeInsetsGeometry.only(right: 8),
                child: Icon(Icons.share, color: AppColors.white),
              ),
              onTap: _shareReferralCode,
            ),
          ],
        ),
      ),
    );
  }

  void _shareReferralCode() {
    final String referralCode = '4 5 b 7'; // Your referral code here
    Share.share('Use my referral code: $referralCode to get discounts!');
  }

  Widget _stepLine() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      width: 2,
      height: 20,
      color: Colors.grey,
    );
  }

  Widget _buildReferralStep(String title, String description, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20.sp, // Scalable icon size
          ),
        ),
        SizedBox(width: 10.w), // Scalable width
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                title,
                size: 16, // Scalable font size

                maxline: 1,
                isBold: true,
              ),
              CommonText(
                description,
                maxline: 1,
                size: 12, // Scalable font size
              ),
            ],
          ),
        ),
      ],
    );
  }
}
