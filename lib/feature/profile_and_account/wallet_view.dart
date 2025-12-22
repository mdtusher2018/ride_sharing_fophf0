import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/utills/app_colors.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: commonAppBar(context, title: "Wallet"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WalletBalanceCard(),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: SectionHeader(title: 'Recent Activity')),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, Color(0xFF166729)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: CommonText(
                    "Earned : \$2500",
                    color: AppColors.white,
                    isBold: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ActivityList(),
          ],
        ),
      ),
    );
  }
}

/// --------------------
/// Wallet Balance Card
/// --------------------
class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F2027), Color(0xFF203A43)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CommonText('TOTAL BALANCE', color: Colors.white70, size: 12),
                SizedBox(height: 8),
                CommonText(
                  '\$-245.00',
                  color: Colors.white,
                  size: 28,
                  isBold: true,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CommonImage(
              path: "assest/image/circle.png",
              height: 80,
              sourceType: ImageSourceType.asset,
            ),
          ),
        ],
      ),
    );
  }
}

/// --------------------
/// Section Header
/// --------------------
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.rotate(
          angle: pi / 4,
          child: const Icon(
            Icons.square_rounded,
            size: 20,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 8),
        CommonText(title, fontWeight: FontWeight.w600, size: 16),
      ],
    );
  }
}

/// --------------------
/// Activity List
/// --------------------
class ActivityList extends StatelessWidget {
  const ActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      ActivityModel(
        'Trip : Madrid to Barcelona',
        'Today, 10:25 AM',
        '-\$12.50',
        true,
      ),
      ActivityModel(
        'Trip : Madrid to Barcelona',
        'Today, 10:25 AM',
        '-\$12.50',
        true,
      ),
      ActivityModel(
        'Drive : Madrid to Barcelona',
        'Today, 10:25 AM',
        '+\$12.50',
        false,
      ),
      ActivityModel(
        'Drive : Madrid to Barcelona',
        'Today, 10:25 AM',
        '+\$12.50',
        false,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: activities
            .map((activity) => ActivityTile(activity: activity))
            .toList(),
      ),
    );
  }
}

class ActivityModel {
  final String title;
  final String time;
  final String amount;
  final bool isNegative;

  ActivityModel(this.title, this.time, this.amount, this.isNegative);
}

/// --------------------
/// Activity Tile
/// --------------------
class ActivityTile extends StatelessWidget {
  final ActivityModel activity;
  const ActivityTile({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    final color = activity.isNegative ? Colors.red : Colors.green;
    final icon = activity.isNegative
        ? Transform.rotate(
            angle: pi,
            child: Icon(Icons.arrow_outward_outlined, color: color, size: 18),
          )
        : Icon(Icons.arrow_outward_rounded, color: color, size: 18);

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: icon,
          ),
          title: CommonText(activity.title, fontWeight: FontWeight.w500),
          subtitle: CommonText(activity.time, size: 12),
          trailing: CommonText(
            activity.amount,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
