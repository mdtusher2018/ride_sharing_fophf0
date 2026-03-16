import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/utils/defult_values.dart';
import 'package:velozaje/feature/profile_and_account/change_password_view.dart';

import 'package:velozaje/feature/profile_and_account/contact_view.dart';
import 'package:velozaje/controllers/profile_controller.dart';
import 'package:velozaje/feature/profile_and_account/profile_details.dart';
import 'package:velozaje/feature/profile_and_account/referal_view.dart';
import 'package:velozaje/feature/profile_and_account/terms_and_conditions_view.dart';
import 'package:velozaje/feature/profile_and_account/wallet_view.dart';
import 'package:velozaje/feature/vehicale/view/register_vehicale_view.dart';
import 'package:velozaje/feature/widget/common_confirmnation_dialog.dart';
import 'package:velozaje/main.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileControllerProvider.notifier).getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.mainbg,
      appBar: AppBar(
        title: CommonText(
          AppLocalizations.of(context)!.account,
          size: 20,
          isBold: true,
        ),
        centerTitle: true,
        leading: SizedBox(),
        backgroundColor: AppColors.mainbg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(profileControllerProvider.notifier).getProfile();
        },
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
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
                              path: state.user?.image,
                              width: 80.w,
                              sourceType: ImageSourceType.network,
                              height: 80.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                state.user?.fullName ?? AppDefaultValue.name,
                                size: 14,
                                isBold: true,
                              ),
                              SizedBox(height: 4.h),
                              CommonText(
                                state.user?.email ?? AppDefaultValue.email,
                                size: 12,
                                maxline: 1,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),
                        ),

                        CommonText(
                          '\$${state.user?.bookingCount ?? AppDefaultValue.bookingCount}',
                          size: 16,
                          isBold: true,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),

                  _divider(),
                  _tile(
                    AppLocalizations.of(context)!.profile,
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
                    AppLocalizations.of(context)!.change_password,
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
            _sectionTitle(AppLocalizations.of(context)!.general),
            _card(
              child: Column(
                children: [
                  _tile(
                    AppLocalizations.of(context)!.referral_code,
                    "assest/icon/payment.png",
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ReferralsPage(
                              referrals: state.user?.referralCode ?? "N/A",
                            );
                          },
                        ),
                      );
                    },
                  ),

                  if (state.user?.driverVerified ?? false) ...[
                    _divider(),

                    _tile(
                      AppLocalizations.of(context)!.wallet_transactions,
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
                  ] else ...[
                    if (state.user == null || state.user!.vehicale == null)
                      _divider(),
                    _tile(
                      AppLocalizations.of(context)!.register_your_car,
                      "assest/icon/register_your_car.png",
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterVehiclePage(),
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: 16.h),

            /// APP PREFERENCES CARD
            _sectionTitle(AppLocalizations.of(context)!.app_preferences),
            _card(
              child: Column(
                children: [
                  _switchTile(
                    AppLocalizations.of(context)!.notifications,
                    Icons.notifications,
                  ),
                  _divider(),
                  _tile(
                    AppLocalizations.of(context)!.language,
                    "assest/icon/language.png",

                    trailing:
                        Localizations.localeOf(context).languageCode == 'es'
                        ? 'Español'
                        : 'English',
                    ontap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context2) => _languageBottomSheet(context),
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            /// SUPPORT & LEGAL CARD
            _sectionTitle(AppLocalizations.of(context)!.support_legal),
            _card(
              child: Column(
                children: [
                  _tile(
                    AppLocalizations.of(context)!.contact,
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
                    AppLocalizations.of(context)!.terms_conditions,
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
                  _tile(
                    AppLocalizations.of(context)!.log_out,
                    "assest/icon/logout.png",
                    ontap: () {
                      commonConfirmationDialog(
                        context: context,
                        title: "Are you sure you want to log out?",
                        message:
                            "Logging out will end your current session. Do you want to continue?",
                        cancelButtonText: "Cancel",
                        actionButtonText: "Log Out",
                        onCancel: () {
                          Navigator.pop(context);
                        },
                        onAction: () {
                          ref.read(authControllerProvider).logout();
                        },
                      );
                    },
                  ),
                  _divider(),
                  _tile(
                    AppLocalizations.of(context)!.delete_account,
                    "assest/icon/delete.png",
                    isRed: true,
                    ontap: () {
                      commonConfirmationDialog(
                        context: context,
                        title: "Are you sure you want to delete your account?",
                        message:
                            "Deleting your account will permanently remove all your data. This action cannot be undone.",
                        cancelButtonText: "Cancel",
                        actionButtonText: "Delete Account",
                        onCancel: () {
                          Navigator.pop(context);
                        },
                        onAction: () {
                          ref.read(authControllerProvider).deleteAccount();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- HELPERS ----------
  Widget _languageBottomSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('English'),
            onTap: () {
              MyApp.setLocale(context, const Locale('en', 'US'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Español'),
            onTap: () {
              MyApp.setLocale(context, const Locale('es', 'ES'));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

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
