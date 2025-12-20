import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/tips_and_publications/my_tip_details_view.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_text.dart';

class MyTipsPage extends StatefulWidget {
  const MyTipsPage({super.key});

  @override
  State<MyTipsPage> createState() => _MyTipsPageState();
}

class _MyTipsPageState extends State<MyTipsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MyTipDetailsPage();
                },
              ),
            );
          },
          child: MyTipCard(),
        );
      },
    );
  }
}

class MyTipCard extends StatefulWidget {
  const MyTipCard({super.key});

  @override
  State<MyTipCard> createState() => _MyTipCardState();
}

class _MyTipCardState extends State<MyTipCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            status("Confirmed"),
            SizedBox(height: 8.h),
            _header(),
            SizedBox(height: 12.h),
            _verticalStepper(),
            SizedBox(height: 12.h),
            Divider(),
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText("Start Code"),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CommonText(
                      "4 9 2 1",
                      size: 16,
                      color: AppColors.primary,
                      isBold: true,
                    ),
                    CommonText("Give at Pickup", size: 10),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget status(String status) {
    final Color color = (status == "Confirmed")
        ? Color(0xff28A745)
        : (status == "Pending")
        ? Color(0xffB59100)
        : Color(0xffB50000);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(25),
          ),
          child: CommonText(status, color: color, size: 12),
        ),
        CommonText("Saturday 10/20/25", fontWeight: FontWeight.w500),
      ],
    );
  }

  Widget _header() {
    return Row(
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
                ],
              ),
              CommonText("\$280", size: 16, isBold: true),
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
}
