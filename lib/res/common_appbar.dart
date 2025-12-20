import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_text.dart';

AppBar commonAppBar(
  BuildContext context, {
  required String title,
  Widget? actionWidget,
  backgroundColor = AppColors.mainbg,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    leading: Padding(
      padding: EdgeInsets.only(left: 16.r, top: 8, bottom: 8),
      child: InkWell(
        onTap: () => Navigator.maybePop(context),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
    ),
    centerTitle: true,
    title: CommonText(title, size: 18, isBold: true),
    actions: [
      actionWidget ?? SizedBox(),
      SizedBox(width: 16.w),
    ],
  );
}
