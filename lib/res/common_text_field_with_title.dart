import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_text.dart';

class CommonTextfieldWithTitle extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final bool isBold;
  final bool issuffixIconVisible;
  final bool isPasswordVisible;
  final bool? enable;
  final double textSize;
  final Widget? suffixIcon;
  final Widget? prefixIconWidget; // new
  final double borderWidth;
  final double? scale;
  final bool optional;
  final VoidCallback? changePasswordVisibility;
  final TextInputType keyboardType;
  final String? assetIconPath;
  final Color borderColor;
  final int maxLine;
  final Function(String)? onsubmit;
  final Function(String)? onChnage;
  final Function()? onTap;

  const CommonTextfieldWithTitle(
    this.title,
    this.controller, {
    super.key,
    this.focusNode,
    this.hintText = "",
    this.isBold = true,
    this.issuffixIconVisible = false,
    this.isPasswordVisible = false,
    this.enable,
    this.textSize = 14.0,
    this.suffixIcon,
    this.prefixIconWidget, // new
    this.borderWidth = 1.0,
    this.scale = 2.0,
    this.optional = false,
    this.changePasswordVisibility,
    this.keyboardType = TextInputType.text,
    this.assetIconPath,
    this.borderColor = Colors.grey,
    this.maxLine = 1,
    this.onsubmit,
    this.onChnage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              title,
              size: textSize,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            if (optional)
              CommonText("(Optional)", size: textSize, color: Colors.grey),
          ],
        ),
        SizedBox(height: 8.h),
        Material(
          elevation: 0,
          borderRadius: BorderRadius.circular(10.0.r),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0.r),
              border: Border.all(color: borderColor, width: borderWidth),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0.r),
              child: InkWell(
                onTap: onTap,
                child: TextField(
                  controller: controller,

                  enabled: enable,
                  focusNode: focusNode,
                  style: TextStyle(
                    fontSize: textSize.sp,
                    color: AppColors.textPrimary,
                    fontWeight: isBold ? FontWeight.w500 : FontWeight.normal,
                  ),
                  onChanged: onChnage,
                  keyboardType: keyboardType,
                  onSubmitted: onsubmit,
                  maxLines: maxLine,
                  obscureText: isPasswordVisible,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12.r),
                    hintText: hintText,
                    fillColor: AppColors.white,
                    filled: true,
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                    border: InputBorder.none,
                    suffixIcon: (issuffixIconVisible)
                        ? (!isPasswordVisible)
                              ? InkWell(
                                  onTap: changePasswordVisibility,
                                  child: const Icon(Icons.visibility),
                                )
                              : InkWell(
                                  onTap: changePasswordVisibility,
                                  child: const Icon(Icons.visibility_off),
                                )
                        : suffixIcon,
                    prefixIcon:
                        prefixIconWidget ??
                        (assetIconPath != null
                            ? Padding(
                                padding: const EdgeInsets.all(10.0).r,
                                child: Image.asset(
                                  assetIconPath!,
                                  scale: scale,
                                ),
                              )
                            : null),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
