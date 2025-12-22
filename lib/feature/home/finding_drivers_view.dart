import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/result_and_booking/search_results_page.dart';

import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class FindingDriversPage extends StatefulWidget {
  const FindingDriversPage({super.key});

  @override
  State<FindingDriversPage> createState() => _FindingDriversPageState();
}

class _FindingDriversPageState extends State<FindingDriversPage> {
  TextEditingController pickupController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ResultsPage();
          },
        ),
      );
    });
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
                    SizedBox(height: 16.h),

                    /// Handle
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CommonText("Finding your Drivers", size: 16, isBold: true),
                    SizedBox(height: 12.h),
                    LinearProgressIndicator(
                      color: AppColors.primary,
                      minHeight: 5,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          CommonImage(
                            path: "assest/image/finding_driver.png",
                            width: 200,
                            sourceType: ImageSourceType.asset,
                          ),
                          SizedBox(height: 30.h),

                          /// Pickup Location
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

                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
}
