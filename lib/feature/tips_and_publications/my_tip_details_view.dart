// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/feature/tips_and_publications/start_tip_details_view.dart';
import 'package:velozaje/feature/tips_and_publications/widgets/tip_header_card.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class MyTipDetailsPage extends StatelessWidget {
  const MyTipDetailsPage({super.key});

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
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: SingleChildScrollView(
                child: Column(
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
                    Column(
                      children: [
                        TipHeaderCard(isTripStartPage: false,),
                        SizedBox(height: 16.h),
                        Card(
                          color: AppColors.white,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CommonImage(
                                    path: "assest/image/car_1.png",
                                  ),
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
                        //passanger
                        Card(
                          color: AppColors.white,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CommonText(
                                  "Passengers",
                                  size: 16,
                                  isBold: true,
                                ),
                                SizedBox(height: 8.h),

                                ...List.generate(4, (index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Leading image container
                                          Container(
                                            width: 40,
                                            height: 40,
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "https://randomuser.me/api/portraits/men/32.jpg",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),

                                          // Title and Subtitle section
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Title text
                                                CommonText(
                                                  "text",
                                                  size: 14,
                                                  isBold: true,
                                                ),

                                                // Subtitle row with rating
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.orange,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 8),
                                                    CommonText("4.9"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Trailing arrow icon
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          spacing: 16.w,
                          children: [
                            Expanded(
                              child: CommonButton(
                                "Claim",
                                color: Colors.transparent,
                                boarder: Border.all(color: AppColors.error),

                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return StartTipDetailsPage();
                                      },
                                    ),
                                  );
                                },

                                iconWidget: Icon(
                                  Icons.warning_amber,
                                  color: AppColors.error,
                                ),
                                textColor: AppColors.error,
                              ),
                            ),
                            Expanded(
                              child: CommonButton(
                                "Cancel Trip",
                                color: AppColors.error,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                      ],
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
}
