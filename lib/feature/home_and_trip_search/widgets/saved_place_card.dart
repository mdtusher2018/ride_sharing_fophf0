import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velozaje/models/save_location_model.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/core/utils/app_colors.dart';

Widget savedPlaceCard({
  required SavedLocation savedLocationModel,
  required VoidCallback onRemove,
}) {
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
                savedLocationModel.placeName,
                size: 14,
                fontWeight: FontWeight.w500,
              ),
              CommonText(savedLocationModel.address, size: 12.sp),
            ],
          ),
        ),
        InkWell(
          onTap: onRemove,
          child: Icon(Icons.star, color: Colors.yellow),
        ),
      ],
    ),
  );
}
