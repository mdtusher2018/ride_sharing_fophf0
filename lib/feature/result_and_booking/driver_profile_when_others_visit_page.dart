import 'package:flutter/material.dart';
import 'package:velozaje/feature/result_and_booking/report_user.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_text.dart';

class DriverProfilePageWhenOthersVisitsPage extends StatelessWidget {
  const DriverProfilePageWhenOthersVisitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbg,
      appBar: commonAppBar(
        context,
        title: "Driver Profile",
        actionWidget: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ReportUserPage();
                },
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.warning_amber_rounded, color: Colors.red),
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            _ProfileHeader(),
            SizedBox(height: 16),
            _StatsRow(),
            SizedBox(height: 16),
            _AboutSection(),
            SizedBox(height: 16),
            _ReviewsSection(),
          ],
        ),
      ),
    );
  }
}

/// --------------------
/// Profile Header
/// --------------------
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://randomuser.me/api/portraits/men/32.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
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
        const CommonText("Lionel Messi", size: 18, fontWeight: FontWeight.w600),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonText("Level"),
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
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _StatCard(title: "Rating", value: "4.9", icon: Icons.star),
        _StatCard(title: "Trips", value: "142"),
        _StatCard(title: "Experience", value: "3 year"),
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
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          CommonText("About Oswaldo", fontWeight: FontWeight.w600),
          SizedBox(height: 8),
          CommonText(
            "Punctuality. You could smoke. I make stops to go to the bathroom.",
            color: AppColors.grey,
          ),
          SizedBox(height: 16),
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
/// Reviews
/// --------------------
class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonText(
          "Recent Reviews",
          fontWeight: FontWeight.w600,
          size: 14,
        ),

        const SizedBox(height: 12),
        ...List.generate(3, (_) => const _ReviewTile()),
      ],
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 20,
            backgroundImage: NetworkImage(
              "https://randomuser.me/api/portraits/men/32.jpg",
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  children: [
                    CommonText("Maria", fontWeight: FontWeight.w600),

                    SizedBox(width: 6),
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    CommonText("5"),
                  ],
                ),
                SizedBox(height: 4),
                CommonText(
                  "Great Driver, Very Punctual",
                  color: AppColors.grey,
                ),
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
