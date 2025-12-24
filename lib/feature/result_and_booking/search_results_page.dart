import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/feature/result_and_booking/widget/driver_result_card.dart';
import 'package:velozaje/feature/result_and_booking/widget/filter_widget.dart';
import 'package:velozaje/res/common_appbar.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbg,
      appBar: commonAppBar(
        context,
        title: "Results",
        actionWidget: InkWell(
          onTap: () {
            showFilterBottomSheet(context);
          },
          child: Icon(Icons.filter_alt_rounded),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // _tripSummary(),
            // SizedBox(height: 16.h),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16);
                },

                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return DriverResultCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget _tripSummary() {
//   return Container(
//     padding: EdgeInsets.all(14.w),
//     decoration: BoxDecoration(
//       color: AppColors.grey.withOpacity(0.3),
//       borderRadius: BorderRadius.circular(12.r),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CommonText("Barcelona  →  Madrid", size: 15, isBold: true),
//         SizedBox(height: 6.h),
//         CommonText("Sat, Oct 18  •  10:30 PM", size: 12, color: Colors.grey),
//         SizedBox(height: 6.h),
//         Row(
//           children: [
//             Icon(Icons.person, size: 16, color: Colors.grey),
//             SizedBox(width: 6.w),
//             CommonText("1 passengers", size: 12),
//           ],
//         ),
//       ],
//     ),
//   );
// }
