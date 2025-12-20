import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class ConfirmBookingPage extends StatelessWidget {
  const ConfirmBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: AlignmentGeometry.bottomCenter,
        children: [
          /// --------------------
          /// Map Placeholder
          /// --------------------
          CommonImage(
            path: "https://i.sstatic.net/HILmr.png", // map placeholder
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            fit: BoxFit.cover,
            sourceType: ImageSourceType.network,
          ),

          /// --------------------
          /// Bottom Sheet Content
          /// --------------------
          Container(
            padding: const EdgeInsets.all(16),

            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 16.h),
                _VehicleCard(),
                SizedBox(height: 16.h),
                _DriverCard(),
                SizedBox(height: 16.h),

                /// Confirm Button
                CommonButton(
                  "Confirm Booking",
                  onTap: () {
                    _showWaitingDialog(context);
                  },
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),

          Positioned(top: 50, left: 30, child: _BackButton()),
        ],
      ),
    );
  }
}

/// --------------------
/// Back Button
/// --------------------
class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}

/// --------------------
/// Vehicle Card
/// --------------------
class _VehicleCard extends StatelessWidget {
  const _VehicleCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          CommonImage(
            path: "assest/image/taxi.png",
            width: 80,
            sourceType: ImageSourceType.asset,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                CommonText("DHM-GA29-5455", fontWeight: FontWeight.w600),
                SizedBox(height: 4),
                CommonText(
                  "Toyota HR - V | White",
                  size: 12,
                  color: Colors.grey,
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
/// Driver Card
/// --------------------
class _DriverCard extends StatelessWidget {
  const _DriverCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),

      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.amber,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),

          /// Driver Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CommonText("Leo Messi", fontWeight: FontWeight.w600),
                SizedBox(height: 4),
                CommonText(
                  "1,000 Rides",
                  size: 12,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),

          /// Message Icon
          Card(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(Icons.mail, color: Colors.green),
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
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: const Offset(0, -4),
      ),
    ],
  );
}

void _showWaitingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16.h),

              /// Title
              CommonText("Wait for Driver Approval", size: 18, isBold: true),

              SizedBox(height: 8.h),

              /// Subtitle / message
              CommonText(
                "We've sent your request. Waiting for a driver to accept.",
                textAlign: TextAlign.center,
                size: 14,
              ),

              SizedBox(height: 10.h),
            ],
          ),
        ),
      );
    },
  );
}
