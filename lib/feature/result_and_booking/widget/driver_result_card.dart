import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/result_and_booking/result_trip_details.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_text.dart';

class DriverResultCard extends StatefulWidget {
  const DriverResultCard({super.key});

  @override
  State<DriverResultCard> createState() => _DriverResultCardState();
}

class _DriverResultCardState extends State<DriverResultCard> {
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
          SizedBox(height: 12.h),
          _verticalStepper(),
          SizedBox(height: 12.h),
          Divider(),
          SizedBox(height: 10.h),
          if (showPackageOptions) _packageSelector(),
          if (!showPackageOptions) _footer(),
          if (showPackageOptions)
            CommonButton(
              "View Details",
              height: 24,
              textSize: 14,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ResultTripDetailsPage();
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  /// Header (Avatar + Name + Price)
  Widget _header() {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 50,
              margin: EdgeInsets.only(bottom: 8, right: 10),
              height: 50,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText("Lionel Messi", size: 16, isBold: true),
              Row(
                children: [
                  Icon(Icons.star, size: 24, color: Colors.orange),
                  SizedBox(width: 4),
                  CommonText("4.9", size: 14),
                ],
              ),
            ],
          ),
        ),
        CommonText("\$280", size: 16, isBold: true),
      ],
    );
  }

  /// Vertical Stepper
  Widget _verticalStepper() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            children: [
              _stepDot(isActive: true),
              _stepLine(),
              _stepLocation(isActive: false),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _stepText(title: "From", value: "Morelia, Avenida P. Calle 12"),
              SizedBox(height: 10.h),
              _stepText(title: "To", value: "Morelia, Avenida P. Calle 12"),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.grey.withOpacity(.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: CommonText("3h 30m", size: 10),
        ),
      ],
    );
  }

  Widget _stepDot({required bool isActive}) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: isActive ? 7 : 2.5),
      ),
    );
  }

  Widget _stepLocation({required bool isActive}) {
    return Icon(isActive ? Icons.location_on : Icons.location_on_outlined);
  }

  Widget _stepLine() {
    return Container(width: 2, height: 40, color: Colors.grey);
  }

  Widget _stepText({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(title, size: 11, color: Colors.grey),
        SizedBox(height: 2),
        CommonText(value, size: 13, isBold: true),
      ],
    );
  }

  Widget _packageSelector() {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          _sizeCard("Small", "\$60", 0),
          SizedBox(width: 10.w),
          _sizeCard("Medium", "\$00", 1),
          SizedBox(width: 10.w),
          _sizeCard("Large", "\$00", 2),
        ],
      ),
    );
  }

  Widget _sizeCard(String title, String price, int index) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedIndex = index);
        },
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withOpacity(.08)
                : AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              CommonText(title, size: 12),
              SizedBox(height: 6.h),
              CommonText(price, size: 14, isBold: true),
            ],
          ),
        ),
      ),
    );
  }

  /// Footer
  Widget _footer() {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: CommonText("TOYOTA COROLLA", size: 10),
          ),
          const Spacer(),
          CommonButton(
            "View Details",
            onTap: () {
              setState(() {
                showPackageOptions = !showPackageOptions;
              });
            },
            height: 30,
            width: 120,
            textSize: 14,
          ),
        ],
      ),
    );
  }
}
