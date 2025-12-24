import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_otp_field.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/utills/app_colors.dart';

enum Status { pending, pickupCode, ontheway, finalCode, compleated }

class MyPublishedDetailsPage extends StatelessWidget {
  const MyPublishedDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.grey,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: CommonImage(
              path: "https://i.sstatic.net/HILmr.png",
              sourceType: ImageSourceType.network,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 40.h,
            left: 16.w,
            child: InkWell(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(left: 16, top: 6, bottom: 6),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.arrow_back_ios_sharp, color: AppColors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(16.w),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.7,
              ),
              decoration: BoxDecoration(
                color: AppColors.mainbg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _SheetHandle(),
                    SizedBox(height: 12.h),

                    CommonText(
                      'Trip Details',
                      size: 16,
                      fontWeight: FontWeight.w600,
                    ),

                    SizedBox(height: 16.h),

                    _TripSummaryCard(),

                    SizedBox(height: 12.h),

                    _VehicleCard(),

                    SizedBox(height: 16.h),

                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: CommonText(
                        'Confirmed Passengers',
                        size: 14,
                        isBold: true,
                      ),
                    ),
                    _PassengerCard(status: Status.finalCode),
                    _PassengerCard(status: Status.ontheway),
                    _PassengerCard(status: Status.pickupCode),
                    _PassengerCard(status: Status.compleated),

                    SizedBox(height: 12.h),

                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: CommonText(
                        'Pending Requests (2)',
                        size: 14,
                        isBold: true,
                      ),
                    ),
                    _PassengerCard(status: Status.pending),
                    _PassengerCard(status: Status.pending),

                    SizedBox(height: 20.h),

                    _BottomActions(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 4.h,

      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }
}

class _TripSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Color(0xff111827),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CommonText(
                  'Active Trip',
                  size: 12,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              CommonText(
                '\$280',
                size: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: CommonText(
                  'Barcelona to Madrid',
                  size: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              CommonText("Earning", color: AppColors.white),
            ],
          ),

          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _InfoBox(
                icon: Icons.person_2_outlined,
                value: '1/4',
                label: 'Passengers',
              ),
              _InfoBox(
                icon: Iconsax.box_1_outline,
                value: '0',
                label: 'Packages',
              ),
              _InfoBox(
                icon: Iconsax.send_2_outline,
                value: '3.5h',
                label: 'Est. Time',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _InfoBox({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(height: 6.h),
          CommonText(value, color: Colors.white, fontWeight: FontWeight.bold),
          CommonText(label, size: 10, color: Colors.white70),
        ],
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(child: CommonImage(path: "assest/image/car_1.png")),
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
    );
  }
}

class _PassengerCard extends StatelessWidget {
  final Status status;
  const _PassengerCard({required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10.h),

      color: AppColors.white,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 60,
                      margin: EdgeInsets.only(bottom: 8, right: 10),
                      height: 60,
                      decoration: BoxDecoration(
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

                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText("Lionel Messi", size: 14, isBold: true),
                      Row(
                        children: [
                          Icon(Icons.star, size: 20, color: Colors.orange),
                          SizedBox(width: 4),
                          CommonText("4.9", size: 12),
                          SizedBox(width: 8),
                          Icon(
                            Icons.group_outlined,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 4),
                          CommonText(
                            "2 Seats",
                            size: 12,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                      CommonText(
                        "\$280",
                        size: 14,
                        isBold: true,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 2,
                  color: AppColors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.email, color: AppColors.primary),
                  ),
                ),
                Card(
                  elevation: 2,
                  color: AppColors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.person_2, color: AppColors.primary),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            if (status == Status.pending) accetpRejectButton(),
            if (status == Status.pickupCode) pickupCode(),
            if (status == Status.ontheway) onTheWay(),
            if (status == Status.finalCode) finalCode(),
            if (status == Status.compleated) compleate(),
          ],
        ),
      ),
    );
  }

  Widget accetpRejectButton() {
    return Column(
      children: [
        ListView.builder(
          itemCount: 2,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Iconsax.box_1_outline,
                        color: AppColors.textSecondary,
                      ),
                      CommonText(
                        " 1",
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                  Spacer(),
                  CommonText(
                    "21*56*35 (25kg)",
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  Spacer(),
                  CommonText("\$180", color: AppColors.primary, size: 14),
                  Spacer(),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 35,
          child: Row(
            spacing: 8.w,
            children: [
              Expanded(
                child: CommonButton(
                  'Cancel Trip',
                  color: Colors.transparent,
                  textColor: Colors.red,

                  boarder: Border.all(color: Colors.red, width: 2),
                  onTap: () {},
                  height: 20,
                  textSize: 12,
                  boarderRadious: 6,
                ),
              ),
              Expanded(
                child: CommonButton(
                  'Accept',
                  color: Colors.transparent,
                  textColor: Colors.green,
                  boarder: Border.all(color: Colors.green, width: 2),
                  onTap: () {},
                  height: 20,
                  textSize: 12,
                  boarderRadious: 6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget pickupCode() {
    final List<TextEditingController> _controllers = List.generate(
      4,
      (_) => TextEditingController(),
    );
    final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

    void onChanged(String value, int index) {
      if (value.length == 1 && index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else if (value.isEmpty && index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        CommonText("Enter Pickup Code", size: 16, isBold: true),
        CommonText("Asked the Passanger for the code to confirm their pickup"),
        SizedBox(),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return CommonOtpField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      onChanged: (value) => onChanged(value, index),
                    );
                  }),
                ),
              ),
            ),
            CommonButton("Verify", width: 90, height: 30, boarderRadious: 8),
          ],
        ),
      ],
    );
  }

  Widget finalCode() {
    final List<TextEditingController> _controllers = List.generate(
      4,
      (_) => TextEditingController(),
    );
    final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

    void onChanged(String value, int index) {
      if (value.length == 1 && index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else if (value.isEmpty && index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        CommonText("Enter Final Code", size: 16, isBold: true),
        CommonText("Asked the Passanger for the code to confirm their pickup"),
        SizedBox(),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return CommonOtpField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      onChanged: (value) => onChanged(value, index),
                    );
                  }),
                ),
              ),
            ),
            CommonButton("Verify", width: 90, height: 30, boarderRadious: 8),
          ],
        ),
      ],
    );
  }

  Widget compleate() {
    return SizedBox(
      height: 36.h,
      child: CommonButton(
        "Trip Compleated",
        color: AppColors.textSecondary,
        textSize: 12,
        boarderRadious: 5,
        onTap: null,
        iconWidget: Icon(
          Icons.check_circle_outline_outlined,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget onTheWay() {
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText("Trip in Progress", size: 16, isBold: true),
        SizedBox(
          height: 36.h,
          child: CommonButton(
            "Arived at destination",

            textSize: 12,
            boarderRadious: 5,
            onTap: null,
            iconWidget: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Iconsax.send_2_outline, color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CommonButton(
            'Cancel Trip',
            color: Colors.transparent,
            textColor: Colors.red,
            boarder: Border.all(color: Colors.red, width: 2),
            onTap: () {},
            height: 35,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: CommonButton(
            'Start Trip',
            color: Colors.green,
            onTap: () {},
            height: 35,
          ),
        ),
      ],
    );
  }
}
