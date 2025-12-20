import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/home/widgets/date_time_picker.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/utills/app_colors.dart';

enum PublishStep { publishForm, routeSelection, vehicleSpace }

class PublishProcessPage extends StatefulWidget {
  PublishProcessPage({super.key});

  @override
  State<PublishProcessPage> createState() => _PublishProcessPageState();
}

class _PublishProcessPageState extends State<PublishProcessPage> {
  final TextEditingController dateTime = TextEditingController();
  PublishStep currentStep = PublishStep.publishForm;

  int selectedSeats = 1; // default 1 seat
  String selectedTrunk = "Small"; // default trunk
  int selectedRouteIndex = -1; // default selected route
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
            child: Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: _buildBottomView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomView() {
    switch (currentStep) {
      case PublishStep.publishForm:
        return _publishFormView();
      case PublishStep.routeSelection:
        return _routeSelectionView();
      case PublishStep.vehicleSpace:
        return _vehicleSpaceView();
    }
  }

  Widget _publishFormView() {
    return Container(
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
              child: CommonText("Where are you going?", size: 18, isBold: true),
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
            CommonButton(
              "Continue",
              height: 40,
              onTap: () {
                setState(() {
                  currentStep = PublishStep.routeSelection;
                });
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _routeSelectionView() {
    return Container(
      padding: EdgeInsets.all(16.w),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.7,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 12.h,
          children: [
            ...List.generate(3, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedRouteIndex = index;
                  });
                },
                child: _routeTile(isSelected: selectedRouteIndex == index),
              );
            }),

            SizedBox(height: 10.h),

            CommonButton(
              "Continue",
              height: 40,
              onTap: () {
                setState(() {
                  currentStep = PublishStep.vehicleSpace;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _vehicleSpaceView() {
    return Container(
      padding: EdgeInsets.all(16.w),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText("Vehicle & Space", size: 18, isBold: true),

            SizedBox(height: 12.h),

            /// Vehicle card
            Card(
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: CommonImage(path: "assest/image/car_1.png"),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          CommonText("Volkswagen Jetta", size: 14),
                          CommonText("2008", size: 14),
                          CommonText(
                            "kkp-35-466",
                            size: 12,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            /// Empty Seats
            CommonText("Empty Seats", isBold: true),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.grey.withOpacity(0.3),
              ),
              child: Row(
                children: List.generate(4, (index) {
                  final seatNumber = index + 1;
                  final selected = selectedSeats == seatNumber;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSeats = seatNumber;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: selected
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                        ),
                        child: Center(
                          child: CommonText(
                            "$seatNumber",
                            color: selected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            isBold: selected,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: 16.h),

            /// Trunk Space
            CommonText("Trunk Space", isBold: true),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.grey.withOpacity(0.3),
              ),
              child: Row(
                children: ["Small", "Medium", "Large"].map((e) {
                  final selected = selectedTrunk == e;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTrunk = e;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: selected
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                        ),
                        child: Center(
                          child: CommonText(
                            e,
                            color: selected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            isBold: selected,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 30.h), CommonButton("Continue", height: 44),
          ],
        ),
      ),
    );
  }

  Widget _routeTile({bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSelected ? Colors.yellow.shade50 : AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected ? Colors.green : Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText("Barcelona  →  Real Madrid", size: 12),
          SizedBox(height: 4.h),
          Row(
            children: [
              CommonText("113 Km  ", size: 14, isBold: true),
              CommonText(
                "(1h 20 minutes)",
                size: 12,
                isBold: true,
                color: AppColors.textSecondary,
              ),
            ],
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
