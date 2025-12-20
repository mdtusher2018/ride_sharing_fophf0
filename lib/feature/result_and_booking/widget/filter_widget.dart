import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

enum FeatureOption { verifiedProfile, automaticReservation }

void showFilterBottomSheet(BuildContext context) {
  final List<String> vehicleImage = [
    'assest/image/car.png',
    'assest/image/taxi.png',
    'assest/image/bike.png',
    'assest/image/truck.png',
  ];

  final List<String> levels = [
    'assest/image/car.png',
    'assest/image/taxi.png',
    'assest/image/bike.png',
  ];

  int selectedVehicleIndex = -1;
  int selectedLevelIndex = -1;
  int selectedStars = 0;
  FeatureOption? selectedFeature;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: StatefulBuilder(
          builder: (context, setStateSB) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top bar indicator
                    Center(
                      child: Container(
                        width: 50.w,
                        height: 5.h,
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                    ),

                    // Title
                    Center(
                      child: CommonText(
                        'Filters',
                        size: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Vehicle Type
                    CommonText(
                      'Select Vehicle Type',
                      size: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      height: 80.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: vehicleImage.length,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedVehicleIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setStateSB(() {
                                selectedVehicleIndex = index;
                              });
                            },
                            child: Container(
                              width: 90.w,
                              margin: EdgeInsets.only(right: 12.w),
                              decoration: BoxDecoration(
                                color: AppColors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: CommonImage(
                                  path: vehicleImage[index],
                                  sourceType: ImageSourceType.asset,
                                  width: 50.w,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Level
                    CommonText(
                      'Level',
                      size: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      height: 80.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: levels.length,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedLevelIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setStateSB(() {
                                selectedLevelIndex = index;
                              });
                            },
                            child: Container(
                              width: 90.w,
                              margin: EdgeInsets.only(right: 12.w),
                              decoration: BoxDecoration(
                                color: AppColors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: CommonImage(
                                  path: levels[index],
                                  sourceType: ImageSourceType.asset,
                                  width: 50.w,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Stars
                    CommonText(
                      'Stars',
                      size: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            setStateSB(() {
                              selectedStars = index + 1;
                            });
                          },
                          icon: Icon(
                            index < selectedStars
                                ? Icons.star_rate_rounded
                                : Icons.star_border,
                            color: Colors.orange,
                            size: 30,
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 16.h),

                    // Features
                    CommonText("Features", size: 16, isBold: true),
                    SizedBox(height: 8.h),

                    // Verified Profile
                    Row(
                      children: [
                        CommonText('Verified Profile', size: 14.sp),
                        Spacer(),
                        Radio<FeatureOption>(
                          value: FeatureOption.verifiedProfile,
                          groupValue: selectedFeature,
                          onChanged: (value) {
                            setStateSB(() {
                              selectedFeature = value;
                            });
                          },
                        ),
                      ],
                    ),

                    // Automatic Reservation
                    Row(
                      children: [
                        CommonText('Automatic Reservation', size: 14.sp),
                        Spacer(),
                        Radio<FeatureOption>(
                          value: FeatureOption.automaticReservation,
                          groupValue: selectedFeature,
                          onChanged: (value) {
                            setStateSB(() {
                              selectedFeature = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Confirm Button
                    CommonButton(
                      "Confirm Filters",
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
