import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

enum MaterialType { diamond, rock, clay }

class ProfileDetailsPage extends StatelessWidget {
  const ProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbg,
      appBar: commonAppBar(
        context,
        title: "Driver Profile",
        actionWidget: Padding(
          padding: EdgeInsets.only(right: 16),
          child: Image.asset("assest/image/mingcute_edit-line.png", width: 30),
        ),
      ),

      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 10.h,
          children: [
            _HeaderCard(),
            Card(
              elevation: 2,
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: CommonImage(path: "assest/image/car_1.png"),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          CommonText("Volkswagen Jetta", size: 14),
                          CommonText("2008", size: 14),
                          CommonText(
                            "kkp-35-466",
                            size: 12,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            _AboutSection(),

            SummaryCard(),
            SizedBox(height: 16.h),
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
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CommonText("Verifications", fontWeight: FontWeight.w600),
          SizedBox(height: 8),
          _VerificationItem("Verified ID", true),
          _VerificationItem("Confirmed email", true),
          _VerificationItem("Car license plate number", true),
          _VerificationItem("Photo", true),
          _VerificationItem("Vehicle", false),
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

class _HeaderCard extends StatefulWidget {
  const _HeaderCard();

  @override
  State<_HeaderCard> createState() => _HeaderCardState();
}

class _HeaderCardState extends State<_HeaderCard> {
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
          _header(),

          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              "About me",
              size: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 60,
                  margin: EdgeInsets.only(bottom: 8, right: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://randomuser.me/api/portraits/men/32.jpg",
                      ),
                    ),
                    borderRadius: BorderRadius.circular(8),
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
              CommonText("Lionel Messi", size: 16, isBold: true),
              Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.orange),
                  SizedBox(width: 4),
                  CommonText("4.9", size: 12),
                ],
              ),
              CommonText("28 years", size: 12, color: AppColors.textSecondary),
            ],
          ),
        ),
      ],
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
  const SummaryCard({super.key});

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
            _buildStatRow("Completed Trips", "84"),
            Divider(),
            _buildStatRow("Referrals", "84"),
            Divider(),
            _buildStatRow("Member Since", "Dec 2020"),
            Divider(),
            _buildStatRow("Trip Cancellations", "1"),
            Divider(),
            _buildStatRow("Claims", "1", hasClaim: true),
            Divider(),
            _buildStatRow("Reviews", "240", isReview: true),
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
