import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velozaje/controllers/profile_controller.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/utils/helper.dart';
import 'package:velozaje/feature/result_and_booking/report_user.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/models/review_model.dart';
import 'package:velozaje/models/user_model.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class DriverProfileView extends ConsumerStatefulWidget {
  const DriverProfileView({
    super.key,
    required this.id,
    required this.tripId,
    required this.bookingId,
  });
  final String id, tripId, bookingId;

  @override
  ConsumerState<DriverProfileView> createState() => _DriverProfileViewState();
}

class _DriverProfileViewState extends ConsumerState<DriverProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(profileControllerProvider.notifier)
          .getProfileById(id: widget.id);
      ref
          .read(reportControllerProvider.notifier)
          .canIReport(tripId: widget.tripId);
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
        actionWidget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (ref.watch(reportControllerProvider).canIReport)
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ReportUserPage(
                          driverId: widget.id,
                          bookingId: widget.bookingId,
                          tripId: widget.tripId,
                        );
                      },
                    ),
                  );
                },
                child: Badge(
                  label: Text(
                    ref
                        .watch(reportControllerProvider)
                        .reportCount
                        .toStringAsFixed(0),
                  ),
                  isLabelVisible:
                      (ref.watch(reportControllerProvider).reportCount > 0),
                  padding: EdgeInsets.all(0),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                    size: 32,
                  ),
                ),
              ),
          ],
        ),
      ),

      body: ValueListenableBuilder(
        valueListenable: controller.isLoading,
        builder: (_, isLoading, _) {
          if (isLoading || widget.id != state.driver?.id) {
            return Center(child: CircularProgressIndicator());
          }
          if (!isLoading && state.driver == null) {
            return CommonText("Could not fetch driver details");
          }
          return RefreshIndicator(
            onRefresh: () async {
              controller.getProfileById(id: widget.id);
              ref
                  .read(reportControllerProvider.notifier)
                  .canIReport(tripId: widget.tripId);
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _ProfileHeader(driver: state.driver!),
                  SizedBox(height: 16),
                  _StatsRow(driver: state.driver!),
                  SizedBox(height: 16),
                  _AboutSection(driver: state.driver!),
                  SizedBox(height: 16),
                  _ReviewsSection(widget.id),
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
/// Profile Header
/// --------------------
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.driver});
  final UserModel driver;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CommonImage(
              path: driver.image,
              width: 60,
              height: 60,
              sourceType: ImageSourceType.network,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.white,
                child: Icon(Icons.verified, color: AppColors.primary, size: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        CommonText(driver.fullName, size: 18, fontWeight: FontWeight.w600),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonText(AppLocalizations.of(context)!.level),
            SizedBox(width: 4),
            Image.asset("assest/badge/diamond_fill.png", width: 16),
          ],
        ),
      ],
    );
  }
}

/// --------------------
/// Stats Row
/// --------------------
class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.driver});
  final UserModel driver;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
          title: AppLocalizations.of(context)!.rating,
          value: driver.ratting.toStringAsFixed(1),
          icon: Icons.star,
        ),
        _StatCard(
          title: AppLocalizations.of(context)!.trips,
          value: driver.travelCount.toString(),
        ),
        _StatCard(
          title: AppLocalizations.of(context)!.experience,
          value: "${driver.experience.toStringAsFixed(1)} year",
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;

  const _StatCard({required this.title, required this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: _cardDecoration(),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) Icon(icon, color: Colors.amber, size: 20),
                CommonText(
                  value,
                  size: 16,
                  fontWeight: FontWeight.w600,
                  color: icon != null ? Colors.amber : AppColors.textPrimary,
                ),
              ],
            ),
            const SizedBox(height: 4),
            CommonText(title, size: 12, color: AppColors.grey),
          ],
        ),
      ),
    );
  }
}

/// --------------------
/// About & Verifications
/// --------------------
class _AboutSection extends StatelessWidget {
  const _AboutSection({required this.driver});
  final UserModel driver;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            AppLocalizations.of(context)!.about,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 8),
          CommonText(driver.about, color: AppColors.grey),
          SizedBox(height: 16),
          CommonText(
            AppLocalizations.of(context)!.verifications,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 8),
          _VerificationItem(
            AppLocalizations.of(context)!.verified_id,
            driver.driverVerified,
          ),
          _VerificationItem(
            AppLocalizations.of(context)!.confirmed_email,
            driver.driverVerified,
          ),
          _VerificationItem(
            AppLocalizations.of(context)!.car_license_plate_number,
            driver.driverVerified,
          ),
          _VerificationItem(
            AppLocalizations.of(context)!.photo,
            driver.driverVerified,
          ),
          _VerificationItem(
            AppLocalizations.of(context)!.vehicle,
            driver.driverVerified,
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
/// Reviews
/// --------------------
class _ReviewsSection extends ConsumerStatefulWidget {
  const _ReviewsSection(this.id);
  final String id;

  @override
  ConsumerState<_ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends ConsumerState<_ReviewsSection> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(reviewControllerProvider.notifier)
          .getAllReviewById(id: widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reviewControllerProvider);
    final controller = ref.read(reviewControllerProvider.notifier);
    if (controller.isLoading.value && state.items.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else if (state.items.isEmpty) {
      return Column(
        children: [
          Row(
            children: [
              CommonText(
                AppLocalizations.of(context)!.recent_reviews,
                fontWeight: FontWeight.w600,
                size: 14,
              ),
            ],
          ),

          const SizedBox(height: 12),
          CommonText("No review Found"),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          AppLocalizations.of(context)!.recent_reviews,
          fontWeight: FontWeight.w600,
          size: 14,
        ),

        const SizedBox(height: 12),
        ...List.generate(
          state.items.length,
          (index) => _ReviewTile(review: state.items[index]),
        ),
      ],
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});
  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 20,
            backgroundImage: NetworkImage(
              getFullImagePath(review.passengerImage),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CommonText(
                      review.passengerName,
                      fontWeight: FontWeight.w600,
                    ),

                    SizedBox(width: 6),
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    CommonText(review.rating.toStringAsFixed(1)),
                  ],
                ),
                SizedBox(height: 4),
                CommonText(review.review, color: AppColors.grey),
              ],
            ),
          ),
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
