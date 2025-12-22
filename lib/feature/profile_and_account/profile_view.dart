import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/profile_and_account/change_password_view.dart';

import 'package:velozaje/feature/profile_and_account/contact_view.dart';
import 'package:velozaje/feature/profile_and_account/payment_methord_view.dart';
import 'package:velozaje/feature/profile_and_account/profile_details.dart';
import 'package:velozaje/feature/profile_and_account/referal_view.dart';
import 'package:velozaje/feature/profile_and_account/terms_and_conditions_view.dart';
import 'package:velozaje/feature/profile_and_account/wallet_view.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbg,
      appBar: AppBar(
        title: CommonText('Account', size: 20, isBold: true),
        centerTitle: true,
        backgroundColor: AppColors.mainbg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          /// PROFILE CARD
          _card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          border: Border.all(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                        child: ClipOval(
                          child: CommonImage(
                            path:
                                "https://static.vecteezy.com/system/resources/previews/002/002/403/non_2x/man-with-beard-avatar-character-isolated-icon-free-vector.jpg",

                            width: 80.w,
                            sourceType: ImageSourceType.network,
                            height: 80.w,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText('Leo Messi', size: 18, isBold: true),
                          SizedBox(height: 4.h),
                          CommonText(
                            'leomessi@gmail.com',
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                      const Spacer(),
                      CommonText(
                        '\$245',
                        size: 18,
                        isBold: true,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),

                _divider(),
                _tile(
                  'Profile',
                  "assest/icon/profile.png",
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProfileDetailsPage();
                        },
                      ),
                    );
                  },
                ),
                _divider(),
                _tile(
                  'Payment Methods',
                  "assest/icon/payment.png",
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PaymentMethodPage();
                        },
                      ),
                    );
                  },
                ),
                _divider(),
                _tile(
                  'Change Password',
                  "assest/icon/changepassword.png",
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangePasswordPage();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          /// GENERAL CARD
          _sectionTitle('GENERAL'),
          _card(
            child: Column(
              children: [
                _tile(
                  'Referral Code',
                  "assest/icon/payment.png",
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ReferralsPage();
                        },
                      ),
                    );
                  },
                ),
                _divider(),
                _tile(
                  'Wallet & Transactions',
                  "assest/icon/wallet.png",
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WalletPage();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          /// APP PREFERENCES CARD
          _sectionTitle('APP PREFERENCES'),
          _card(
            child: Column(
              children: [
                _switchTile('Notifications', Icons.notifications),
                _divider(),
                _tile(
                  'Language',
                  "assest/icon/language.png",
                  trailing: 'English',
                  ontap: () {},
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          /// SUPPORT & LEGAL CARD
          _sectionTitle('SUPPORT & LEGAL'),
          _card(
            child: Column(
              children: [
                _tile(
                  'Contact',
                  "assest/icon/email.png",
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ContactPage();
                        },
                      ),
                    );
                  },
                ),
                _divider(),
                _tile(
                  'Terms & Conditions',
                  "assest/icon/wallet.png",
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TermsAndConditionsPage();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          _card(
            child: Column(
              children: [
                _tile('Log Out', "assest/icon/logout.png", ontap: () {}),
                _divider(),
                _tile(
                  'Delete Account',
                  "assest/icon/delete.png",
                  isRed: true,
                  ontap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- HELPERS ----------

  Widget _card({required Widget child}) {
    return Card(
      elevation: 1,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: child,
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: CommonText(
        title,
        size: 14,
        isBold: true,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _divider() {
    return Divider(height: 1, color: AppColors.grey);
  }

  Widget _tile(
    String title,
    String icon, {
    bool isRed = false,
    String? trailing,
    required Function() ontap,
  }) {
    return ListTile(
      leading: Image.asset(icon, width: 24, height: 24),
      title: CommonText(
        title,
        size: 16,
        color: isRed ? AppColors.error : AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      trailing: trailing != null
          ? CommonText(trailing, size: 14, color: AppColors.textSecondary)
          : null,
      onTap: ontap,
    );
  }

  Widget _switchTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: CommonText(title, size: 16),
      trailing: Switch(
        value: true,
        activeColor: AppColors.primary,
        onChanged: (val) {},
      ),
    );
  }
}
