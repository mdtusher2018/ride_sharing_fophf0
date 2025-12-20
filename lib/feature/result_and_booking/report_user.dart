import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/res/common_text_field.dart';

class ReportUserPage extends StatefulWidget {
  const ReportUserPage({super.key});

  @override
  State<ReportUserPage> createState() => _ReportUserPageState();
}

class _ReportUserPageState extends State<ReportUserPage> {
  final TextEditingController detailsController = TextEditingController();

  int selectedIndex = -1;

  final List<String> reasons = [
    'Dangerous Driving',
    'Vehicle didn’t match description',
    'Wrong Drop-off',
    'Rude or aggressive behavior',
    'Package damaged or lost',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbg,
      appBar: commonAppBar(context, title: "Report User"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),

            /// Warning box
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: const Color(0xFFFFDDDD),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: CommonText(
                'Please select a reason for reporting Osbaldo Garcia. '
                'This is anonymous and helps keep our community safe.',
                size: 12.sp,
                color: const Color(0xFF910F0F),
              ),
            ),

            SizedBox(height: 20.h),

            /// Reasons (dynamic)
            ...List.generate(reasons.length, (index) {
              return _ReportOption(
                title: reasons[index],
                isSelected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              );
            }),

            SizedBox(height: 24.h),

            CommonText(
              'Additional Details',
              size: 14.sp,
              fontWeight: FontWeight.w600,
            ),

            SizedBox(height: 10.h),

            CommonTextField(
              controller: detailsController,
              hintText: 'Please describe what happened...',
              minLine: 4,
              keyboardType: TextInputType.multiline,
              boarderColor: Colors.transparent,
            ),

            const Spacer(),

            /// Submit button
            CommonButton(
              'Submit Report',
              color: Colors.red.shade600,
              textColor: Colors.white,
              textalign: TextAlign.center,
              height: 50,
              onTap: selectedIndex == -1
                  ? null
                  : () {
                      // submit logic
                    },
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

class _ReportOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ReportOption({
    required this.title,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF2F2) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? Colors.red : Colors.transparent,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              title,
              size: 14.sp,
              color: isSelected ? Colors.red : AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            if (isSelected) const Icon(Icons.check_circle, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
