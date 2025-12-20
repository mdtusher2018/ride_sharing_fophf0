import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbg,
      appBar: AppBar(
        backgroundColor: AppColors.mainbg,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: const Icon(Icons.arrow_back, color: AppColors.white),
            ),
          ),
        ),
        centerTitle: true,
        title: CommonText('Payment Method', size: 18, isBold: true),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText('Payment methods', size: 16, isBold: true),
            SizedBox(height: 12.h),

            /// CARD ITEM
            Card(
              elevation: 1,
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    /// VISA LOGO (placeholder)
                    Container(
                      height: 48.h,
                      width: 48.w,
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.mainbg,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.grey.withOpacity(0.4),
                        ),
                      ),
                      child: CommonImage(path: "assest/image/visa.png"),
                    ),
                    SizedBox(width: 12.w),

                    /// CARD INFO
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          '**** **** **** 5282',
                          size: 16,
                          isBold: true,
                        ),
                        SizedBox(height: 4.h),
                        CommonText(
                          'Expires 12/23',
                          size: 13,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),

                    const Spacer(),

                    /// CHECKBOX
                    Container(
                      height: 20.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

            /// ADD PAYMENT METHOD
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Icon(Icons.add, size: 22.sp, color: AppColors.textPrimary),
                  SizedBox(width: 8.w),
                  CommonText(
                    'Add payments method',
                    size: 16,
                    fontWeight: FontWeight.w500,
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
