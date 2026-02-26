// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/controllers/profile_controller.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/core/utils/helper.dart';
import 'package:velozaje/feature/profile_and_account/edit_profile.dart';
import 'package:velozaje/feature/vehicale/view/register_vehicale_view.dart';
import 'package:velozaje/feature/widget/vehicale_card.dart';
import 'package:velozaje/models/user_model.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class ProfileDetailsPage extends ConsumerStatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  ConsumerState<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends ConsumerState<ProfileDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileControllerProvider.notifier).getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileControllerProvider);
    final controller = ref.read(profileControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.mainbg,
      appBar: commonAppBar(
        context,
        title: AppLocalizations.of(context)!.driver_profile,
        actionWidget: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfilePage(userData: state.user!),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Image.asset(
              "assest/image/mingcute_edit-line.png",
              width: 30,
            ),
          ),
        ),
      ),
      floatingActionButton: (state.user!.vehicale == null)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterVehiclePage(),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : null,

      body: ValueListenableBuilder(
        valueListenable: controller.isLoading,

        builder: (_, isLoading, _) {
          if (isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (!isLoading && state.user == null) {
            return CommonText("Could not fetch user details");
          }
          return RefreshIndicator(
            onRefresh: () async {
              controller.getProfile();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 10.h,
                children: [
                  _HeaderCard(state.user!),
                  if (state.user!.vehicale != null)
                    VehicleCard(
                      image: state.user!.vehicale?.vehicleImages.first ?? "",
                      brand: state.user!.vehicale?.brand ?? "",
                      vehicleModel: state.user!.vehicale?.vehicleModel ?? "",
                      year: state.user!.vehicale?.year.toString() ?? "",
                      licensePlateNumber:
                          state.user!.vehicale?.licensePlateNumber ?? "",
                    ),

                  _AboutSection(state.user!),

                  SummaryCard(state.user!),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// --------------------
/// About & Verifications
/// --------------------
class _AboutSection extends StatelessWidget {
  const _AboutSection(this.user);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            AppLocalizations.of(context)!.verifications,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 8),
          _VerificationItem(
            AppLocalizations.of(context)!.verified_id,
            user.driverVerified,
          ),
          _VerificationItem(
            AppLocalizations.of(context)!.confirmed_email,
            user.driverVerified,
          ),
          _VerificationItem(
            AppLocalizations.of(context)!.car_license_plate_number,
            user.driverVerified,
          ),
          _VerificationItem(
            AppLocalizations.of(context)!.photo,
            user.driverVerified,
          ),
          _VerificationItem(
            AppLocalizations.of(context)!.vehicle,
            user.driverVerified,
          ),
        ],
      ),
    );
  }
}

class _VerificationItem extends StatelessWidget {
  final String title;
  final bool isDone;
  const _VerificationItem(this.title, this.isDone);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            Icons.verified,
            color: isDone ? Colors.blue : AppColors.grey,
            size: 18,
          ),
          const SizedBox(width: 8),
          CommonText(title),
        ],
      ),
    );
  }
}

/// --------------------
/// Card Decoration
/// --------------------
BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppColors.textPrimary.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );
}

class _HeaderCard extends StatelessWidget {
  final UserModel user;
  _HeaderCard(this.user);

  bool showPackageOptions = false;

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.only(right: 10, bottom: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(8),
                          child: CommonImage(
                            path: getFullImagePath(user.image),
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Icon(
                          Icons.verified,
                          color: AppColors.primary,
                          shadows: [Shadow(color: Colors.white)],
                        ),
                      ),
                    ],
                  ),

                  _buildMaterialRow('rock'),
                ],
              ),

              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(user.fullName, size: 16, isBold: true),
                    Row(
                      children: [
                        Icon(Icons.star, size: 20, color: Colors.orange),
                        SizedBox(width: 4),
                        CommonText(user.ratting.toStringAsFixed(1), size: 12),
                      ],
                    ),
                    CommonText(
                      "${user.experience.toInt()} years",
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              AppLocalizations.of(context)!.about_me,
              size: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: CommonText(user.about, color: AppColors.textSecondary),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildMaterialRow(String selectedType) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _materialImage(type: 'clay', selectedType: selectedType),
        SizedBox(width: 12.w),
        _materialImage(type: 'rock', selectedType: selectedType),
        SizedBox(width: 12.w),
        _materialImage(type: 'diamond', selectedType: selectedType),
      ],
    );
  }

  Widget _materialImage({required String type, required String selectedType}) {
    final bool isSelected = type == selectedType;

    return Image.asset(
      isSelected
          ? "assest/badge/${type}_fill.png"
          : 'assest/badge/${type}_fill.png',
      width: 16,
      height: 16,
    );
  }
}

class SummaryCard extends StatelessWidget {
  const SummaryCard(this.user, {super.key});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatRow(AppLocalizations.of(context)!.completed_trips, "84"),
            Divider(),
            _buildStatRow(AppLocalizations.of(context)!.referrals, "84"),
            Divider(),
            _buildStatRow(
              AppLocalizations.of(context)!.member_since,
              "Dec 2020",
            ),
            Divider(),
            _buildStatRow(
              AppLocalizations.of(context)!.trip_cancellations,
              "1",
            ),
            Divider(),
            _buildStatRow(
              AppLocalizations.of(context)!.claims,
              "1",
              hasClaim: true,
            ),
            Divider(),
            _buildStatRow(
              AppLocalizations.of(context)!.reviews,
              "240",
              isReview: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(
    String label,
    String value, {
    bool hasClaim = false,
    bool isReview = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(label, color: AppColors.textSecondary),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonText(value),
              if (hasClaim)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.warning, color: Colors.red, size: 20),
                ),
              if (isReview)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
