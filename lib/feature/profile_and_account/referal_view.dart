import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velozaje/res/common_text.dart';

class ReferralsPage extends StatelessWidget {
  const ReferralsPage({super.key, required this.referrals});
  final String referrals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        title: AppLocalizations.of(context)!.referrals,
      ),
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
                AppLocalizations.of(context)!.percent_commission_free,
                size: 18, // Scalable font size
                color: AppColors.primary,
                isBold: true,
              ),
            ),
            SizedBox(height: 8.h), // Scalable height
            Center(
              child: CommonText(
                AppLocalizations.of(context)!.on_your_next_published_trip,
                size: 14,
              ),
            ),
            SizedBox(height: 24.h), // Scalable height
            _buildReferralStep(
              AppLocalizations.of(context)!.share_your_code,
              AppLocalizations.of(context)!.send_your_unique_code_to_friends,
              Icons.share_outlined,
            ),
            _stepLine(),
            _buildReferralStep(
              AppLocalizations.of(context)!.friend_joins,
              AppLocalizations.of(
                context,
              )!.your_friend_records_it_when_signing_up,
              Iconsax.profile_2user_outline,
            ),
            _stepLine(),
            _buildReferralStep(
              AppLocalizations.of(context)!.you_both_win,
              AppLocalizations.of(
                context,
              )!.get_discounts_on_your_trips_automatically,

              Iconsax.ticket_2_outline,
            ),
            SizedBox(height: 24.h),

            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
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
                    CommonText(AppLocalizations.of(context)!.your_code),
                    CommonText(
                      referrals.isEmpty ? "N/A" : referrals,
                      size: 24, // Scalable font size
                      color: AppColors.primary,
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),

            CommonButton(
              AppLocalizations.of(context)!.share_code,
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
    SharePlus.instance.share(
      ShareParams(
        text:
            'Use my referral code: ${referrals.isEmpty ? "N/A" : referrals} to get discounts!',
      ),
    );
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
            size: 20, // Scalable icon size
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
