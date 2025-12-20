import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Contact"),
      backgroundColor: AppColors.mainbg,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _contactCard(
              title: "Email Us",
              iconPath: "assest/image/gmail.png",
              onTap: () {},
            ),
            SizedBox(height: 12.h),
            _contactCard(
              title: "Facebook",
              iconPath: "assest/image/facebook.png",
              onTap: () {},
            ),
            SizedBox(height: 12.h),
            _contactCard(
              title: "Instagram",
              iconPath: "assest/image/instagram.png",
              onTap: () {},
            ),
            SizedBox(height: 12.h),
            _contactCard(
              title: "+880 4545 8788",
              iconPath: "assest/image/call.png",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactCard({
    required String title,
    required String iconPath,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 1,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      child: InkWell(
        borderRadius: BorderRadius.circular(4.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              CommonImage(
                path: iconPath,
                width: 24.w,
                height: 24.w,
                sourceType: ImageSourceType.asset,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CommonText(title, size: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
