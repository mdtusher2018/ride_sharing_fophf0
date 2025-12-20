import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class PublishedSucessfullPage extends StatelessWidget {
  const PublishedSucessfullPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(16.r),
        child: Column(
          children: [
            Spacer(),
            CommonImage(
              path: "assest/image/compleate.png",
              width: 250,
              height: 250,
              sourceType: ImageSourceType.asset,
            ),

            SizedBox(
              height: 60,
              child: FittedBox(
                child: CommonText("Trip Published", size: 24, isBold: true),
              ),
            ),
            CommonText(
              "Passengers can now book your ride to Madrid",
              size: 14,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 20.h),
            CommonButton("View My Trips"),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
