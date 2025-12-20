import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/feature/home/travel_view.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isTravelSelected = true;
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// 🗺️ Map Placeholder
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

          /// 🟢 Top Header
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 48.h,
                bottom: 30.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: AppColors.primary),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        "Where to?",
                        size: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      CommonText(
                        "Find a ride or send a package",
                        size: 12.sp,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.notifications, color: Colors.white),
                ],
              ),
            ),
          ),

          /// ⬆️ Bottom Sheet Card
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16.w),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 12.h),

                    /// Travel / Send Package Tabs
                    Container(
                      height: 45.h,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          _tabButton("Travel", isTravelSelected, () {
                            setState(() => isTravelSelected = true);
                          }),
                          _tabButton("Send Package", !isTravelSelected, () {
                            setState(() => isTravelSelected = false);
                          }),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),
                    searchBar(
                      controller: TextEditingController(),
                      hintText: "Enter destination",
                      onChanged: (value) {
                        // TODO: search logic
                      },
                      onSubmit: (location) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TravelPage();
                            },
                          ),
                        );
                      },
                      onClear: () {
                        setState(() {});
                      },
                    ),

                    SizedBox(height: 12.h),

                    /// Saved Places
                    _savedPlaceTile(issBookMarks: true),
                    SizedBox(height: 10.h),
                    _savedPlaceTile(),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔘 Tab Button
  Widget _tabButton(String text, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: CommonText(
            text,
            size: 14.sp,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.primary : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget searchBar({
    required TextEditingController controller,
    String hintText = "Enter destination",
    VoidCallback? onClear,
    Function(String)? onSubmit,
    ValueChanged<String>? onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey, size: 22.sp),
          SizedBox(width: 8.w),

          /// Text Field
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmit,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),

          /// Clear Button
          if (controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                controller.clear();
                if (onClear != null) onClear();
              },
              child: Icon(Icons.close, size: 18.sp, color: Colors.grey),
            ),
        ],
      ),
    );
  }

  Widget _savedPlaceTile({bool issBookMarks = false}) {
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
}
