import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/res/common_text_field.dart';

class RateDriverBottomSheet extends StatefulWidget {
  const RateDriverBottomSheet({super.key});

  @override
  State<RateDriverBottomSheet> createState() => _RateDriverBottomSheetState();
}

class _RateDriverBottomSheetState extends State<RateDriverBottomSheet> {
  int selectedRating = 4;
  final TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Drag handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            SizedBox(height: 16.h),

            /// Title
            CommonText(
              'Rate Your Driver',
              size: 18.sp,
              fontWeight: FontWeight.w600,
            ),

            SizedBox(height: 16.h),

            /// Avatar
            CircleAvatar(
              radius: 32.r,
              backgroundColor: Colors.grey.shade200,
              child: ClipOval(
                child: CommonImage(
                  path: 'assets/images/profile_placeholder.png',
                  width: 60,
                  height: 60,
                ),
              ),
            ),

            SizedBox(height: 8.h),

            CommonText('Leo Messi', size: 14.sp, fontWeight: FontWeight.w500),

            SizedBox(height: 20.h),

            /// ⭐ Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRating = index + 1;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Icon(
                      Icons.star,
                      size: 32.sp,
                      color: index < selectedRating
                          ? const Color(0xFFF5B400)
                          : Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            /// Comment Box
            CommonTextField(
              controller: reviewController,
              hintText: 'Write your feedback...',
              minLine: 4,
              keyboardType: TextInputType.multiline,
            ),

            SizedBox(height: 20.h),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    'Skip',
                    color: Colors.white,
                    textColor: Colors.black,
                    boarder: Border.all(color: Colors.grey),
                    textalign: TextAlign.center,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CommonButton(
                    'Submit',
                    color: Colors.green,
                    textColor: Colors.white,
                    textalign: TextAlign.center,
                    onTap: () {
                      // handle submit
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
