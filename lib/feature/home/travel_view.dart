import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velozaje/feature/home/saved_place_view.dart';
import 'package:velozaje/feature/home/widgets/saved_place_card.dart';

import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/feature/home/take_image_view.dart';
import 'package:velozaje/feature/home/widgets/date_time_picker.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  bool isTravelSelected = true;
  int personCount = 1;
  int packageCount = 0;
  final TextEditingController dateTime = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController pickupController = TextEditingController();

  // Declare controllers for each input field
  List<TextEditingController> weightControllers = [];

  void _initializeControllers() {
    // Ensure the list is cleared before adding new controllers
    weightControllers.clear();

    for (int i = 0; i < packageCount; i++) {
      // Create a new controller for each "weight card"
      weightControllers.add(TextEditingController());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeControllers();
  }

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

          /// ⬆️ Bottom Sheet Card
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16.w),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.8,
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
                    /// Handle
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),

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

                    _locationTile(
                      "Pick-up location",
                      controller: pickupController,
                      icon: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 7),
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    /// Destination
                    _locationTile(
                      "Destination",
                      icon: Icon(Icons.location_on),
                      controller: destinationController,
                    ),

                    SizedBox(height: 12.h),

                    /// Time & Counter
                    Row(
                      spacing: 12,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final DateTime? result =
                                  await showDateTimePickerDialog(context);

                              if (result != null) {
                                print("Selected DateTime: $result");
                                setState(() {
                                  dateTime.text =
                                      "${result.day}/${result.month}/${result.year}";
                                });
                              }
                            },
                            child: _infoBox(
                              Icons.calendar_month,
                              (dateTime.text.isNotEmpty)
                                  ? dateTime.text
                                  : "Time & Date",
                            ),
                          ),
                        ),

                        Expanded(
                          child: isTravelSelected
                              ? _counterBoxForPerson()
                              : _counterBoxForPackage(),
                        ),
                      ],
                    ),

                    if (!isTravelSelected) ...[
                      SizedBox(height: 12.h),

                      ListView.separated(
                        padding: EdgeInsets.all(0),
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10.h);
                        },
                        shrinkWrap: true, // Prevents infinite height error
                        itemCount: packageCount,
                        itemBuilder: (context, index) {
                          return weightCard(
                            index,
                          ); // Add a weightCard for each count
                        },
                      ),
                    ],

                    SizedBox(height: 16.h),

                    /// Saved Places
                    savedPlaceCard(issBookMarks: true),
                    SizedBox(height: 10.h),
                    savedPlaceCard(),

                    SizedBox(height: 10.h),
                    _savedPlaceCard(),
                    SizedBox(height: 20.h),

                    /// Search Button
                    CommonButton(
                      "Search Trips",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TakePhotoPage();
                            },
                          ),
                        );
                      },
                      height: 40,
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget weightCard(int index) {
    return SizedBox(
      height: 75,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText("Weight (kg)", size: 10.sp),

                  TextField(
                    keyboardType: TextInputType.number,
                    controller: weightControllers[index],
                    decoration: InputDecoration(
                      hintText: "0",
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          hintText: "L",
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                CommonText(" x "),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Center(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: "W",
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                CommonText(" x "),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          hintText: "H",
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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

  /// 📍 Location Tile
  Widget _locationTile(
    String title, {
    required TextEditingController controller,
    required Widget icon,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          icon,
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: title,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ℹ️ Info Box
  Widget _infoBox(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          SizedBox(width: 8.w),
          Expanded(child: CommonText(text, size: 13.sp)),
        ],
      ),
    );
  }

  /// ➕➖ Counter Box
  Widget _counterBoxForPerson() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.person_2_outlined),
          SizedBox(width: 16.w),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (personCount > 1) setState(() => personCount--);
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),

                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.remove),
                  ),
                ),
                CommonText(personCount.toString(), size: 14.sp),
                InkWell(
                  onTap: () {
                    setState(() => personCount++);
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),

                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _counterBoxForPackage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Iconsax.box_1_outline),
          SizedBox(width: 16.w),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (packageCount > 0) {
                      setState(() {
                        packageCount--;
                      });
                    }
                    // Initialize the controllers when package count changes
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),

                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.remove),
                  ),
                ),
                CommonText(packageCount.toString(), size: 14.sp),
                InkWell(
                  onTap: () {
                    setState(() {
                      packageCount++;
                    });
                    _initializeControllers();
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),

                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ⭐ Saved Place Tile
  Widget _savedPlaceCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SavedPlacePage();
            },
          ),
        );
      },
      child: Container(
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
              child: Icon(Icons.star),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    "Saved Places",
                    size: 14.sp,
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
