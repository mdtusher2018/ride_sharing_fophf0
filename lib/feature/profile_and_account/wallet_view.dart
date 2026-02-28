import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/controllers/wallet_and_payment_controller.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/utils/helper.dart';
import 'package:velozaje/models/response/wallet_response.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';

import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/core/utils/app_colors.dart';
part 'payment_dialog_part_of_wallat_view.dart';

class WalletPage extends ConsumerStatefulWidget {
  const WalletPage({super.key});

  @override
  ConsumerState<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<WalletPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(walletControllerProvider.notifier).refresh();
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 200) {
        ref.read(walletControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(walletControllerProvider);
    final controller = ref.read(walletControllerProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: commonAppBar(
        context,
        title: AppLocalizations.of(context)!.wallet,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WalletBalanceCard(controller: controller),
            SizedBox(height: 12),
            CommonButton(
              "Pay Commission",
              onTap: () {
                showPayCommissionDialog(controller, context);
              },
            ),
            SizedBox(height: 24),

            Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SectionHeader(
                        title: AppLocalizations.of(context)!.recent_activity,
                      ),
                    ),
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
                        "Earned : \$${controller.completedPayments}",
                        color: AppColors.white,
                        isBold: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 12),

            Expanded(
              child: ActivityList(
                controller: scrollController,
                earnings: state.items,
                isLoadingMore: state.isLoadingMore,
              ),
            ),
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
  final WalletAndPaymentController controller;

  const WalletBalanceCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F2027), Color(0xFF203A43)],
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  AppLocalizations.of(context)!.total_balance,
                  color: Colors.white70,
                  size: 12,
                ),
                SizedBox(height: 8),
                CommonText(
                  '\$${controller.completedPayments}',
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
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.only(
                bottomRight: Radius.circular(16),
              ),
              child: CommonImage(
                path: "assest/image/circle.png",
                height: 80,
                sourceType: ImageSourceType.asset,
              ),
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
    return Column(
      children: [
        Row(
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
        ),
      ],
    );
  }
}

/// --------------------
/// Activity List
/// --------------------

class ActivityList extends StatelessWidget {
  final ScrollController controller;
  final List<EarningModel> earnings;
  final bool isLoadingMore;

  const ActivityList({
    super.key,
    required this.controller,
    required this.earnings,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    if (earnings.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.builder(
        controller: controller,
        itemCount: earnings.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (_, index) {
          if (index >= earnings.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return ActivityTile(earning: earnings[index]);
        },
      ),
    );
  }
}

class ActivityTile extends StatelessWidget {
  final EarningModel earning;

  const ActivityTile({super.key, required this.earning});
  String lastTwoWords(String text) {
    final words = text.split(' ');
    if (words.length <= 2) return text;
    return words.sublist(words.length - 2).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final amount = earning.driverEarnings;
    final isNegative = amount < 0;
    final color = isNegative ? Colors.red : Colors.green;

    final icon = isNegative
        ? Transform.rotate(
            angle: pi,
            child: Icon(Icons.arrow_outward, color: color, size: 18),
          )
        : Icon(Icons.arrow_outward, color: color, size: 18);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.15),
        child: icon,
      ),
      title: CommonText(
        "Trip • ${lastTwoWords(earning.pickupLocation)} to ${lastTwoWords(earning.dropoffLocation)}",
        fontWeight: FontWeight.w500,
        maxline: 2,
        size: 13,
      ),
      subtitle: CommonText(formatDateTime(earning.completedAt), size: 12),
      trailing: CommonText(
        "${amount >= 0 ? '+' : ''}\$${amount.toStringAsFixed(1)}",
        color: color,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
