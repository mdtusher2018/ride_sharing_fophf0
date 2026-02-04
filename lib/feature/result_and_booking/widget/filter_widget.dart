import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/utils/app_colors.dart';
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
    'assest/badge/rock_fill.png',
    'assest/badge/clay_fill.png',
    'assest/badge/diamond_fill.png',
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
                        AppLocalizations.of(context)!.filters,
                        size: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Vehicle Type
                    CommonText(
                      AppLocalizations.of(context)!.select_vehicle_type,
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

                    CommonText(
                      AppLocalizations.of(context)!.level,
                      size: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      height: 60.h,
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
                              width: 60.w,

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
                                  width: 24,
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
                      AppLocalizations.of(context)!.stars,
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
                    CommonText(
                      AppLocalizations.of(context)!.features,
                      size: 16,
                      isBold: true,
                    ),
                    SizedBox(height: 8.h),

                    // Verified Profile
                    Row(
                      children: [
                        CommonText(
                          AppLocalizations.of(context)!.verified_profile,
                          size: 14.sp,
                        ),
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
                        CommonText(
                          AppLocalizations.of(context)!.automatic_reservation,
                          size: 14.sp,
                        ),
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
                      AppLocalizations.of(context)!.confirm_filters,
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
