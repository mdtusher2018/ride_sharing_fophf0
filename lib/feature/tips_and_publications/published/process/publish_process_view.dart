import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/home/widgets/date_time_picker.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/utills/app_colors.dart';

class PublishProcessPage extends StatefulWidget {
  PublishProcessPage({super.key});

  @override
  State<PublishProcessPage> createState() => _PublishProcessPageState();
}

class _PublishProcessPageState extends State<PublishProcessPage> {
  final TextEditingController dateTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.grey,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: CommonImage(
              path: "https://i.sstatic.net/HILmr.png",
              sourceType: ImageSourceType.network,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 40.h,
            left: 16.w,
            child: InkWell(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(left: 16, top: 6, bottom: 6),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.arrow_back_ios_sharp, color: AppColors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(16.w),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.7,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10.h,
                  children: [
                    Align(
                      alignment: AlignmentGeometry.centerLeft,
                      child: CommonText(
                        "Where are you going?",
                        size: 18,
                        isBold: true,
                      ),
                    ),
                    SizedBox(),
                    _locationTile(
                      "Pick-up location",
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 7),
                        ),
                      ),
                    ),

                    /// Destination
                    _locationTile("Destination", Icon(Icons.location_on)),

                    InkWell(
                      onTap: () async {
                        final DateTime? result = await showDateTimePickerDialog(
                          context,
                        );

                        if (result != null) {
                          print("Selected DateTime: $result");
                          setState(() {
                            dateTime.text = dateTime.text =
                                "${result.day}/${result.month}/${result.year} ${result.hour}:${result.minute}";
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: AppColors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month, color: Colors.grey),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: CommonText(
                                (dateTime.text.isNotEmpty)
                                    ? dateTime.text
                                    : "Time & Date",
                                size: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(),
                    CommonButton("Continue", height: 40),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationTile(String title, Widget icon) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          icon,
          SizedBox(width: 12.w),
          CommonText(title, size: 14.sp),
        ],
      ),
    );
  }
}
