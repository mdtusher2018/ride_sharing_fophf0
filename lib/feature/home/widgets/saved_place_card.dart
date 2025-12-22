import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/utills/app_colors.dart';

/// ⭐ Saved Place Tile
Widget savedPlaceCard({bool issBookMarks = false}) {
  return Container(
    padding: EdgeInsets.all(14.w),
    margin: EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8.r),
      boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.grey.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Iconsax.clock_bold, color: Colors.grey),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                "Titumir University",
                size: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              CommonText("Mohakhali, Dhaka", size: 12.sp),
            ],
          ),
        ),
        Column(
          children: [
            Icon(
              (issBookMarks) ? Icons.star : Icons.star_border,
              color: issBookMarks ? Colors.yellow : AppColors.grey,
            ),
            CommonText("5.5 km", size: 10),
          ],
        ),
      ],
    ),
  );
}
