import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/result_and_booking/confirm_booking_page.dart';
import 'package:velozaje/feature/result_and_booking/driver_profile_when_others_visit_page.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class ResultTripDetailsPage extends StatelessWidget {
  const ResultTripDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Trip"),
      backgroundColor: AppColors.mainbg,
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _HeaderCard(),
              SizedBox(height: 16.h),
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
              //passanger
              Card(
                color: AppColors.white,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonText("Passengers", size: 16, isBold: true),
                      SizedBox(height: 8.h),

                      ...List.generate(4, (index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                    borderRadius: BorderRadius.circular(8),
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
              CommonButton(
                "See on Map",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ConfirmBookingPage();
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderCard extends StatefulWidget {
  const _HeaderCard();

  @override
  State<_HeaderCard> createState() => _HeaderCardState();
}

class _HeaderCardState extends State<_HeaderCard> {
  bool showPackageOptions = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _header(),
          SizedBox(height: 12.h),
          _verticalStepper(),
          SizedBox(height: 12.h),
          Divider(),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              "Trip details",
              size: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  /// Header (Avatar + Name + Price)
  Widget _header() {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: 60,
              margin: EdgeInsets.only(bottom: 8, right: 10),
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://randomuser.me/api/portraits/men/32.jpg",
                  ),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Icon(
                Icons.verified,
                color: AppColors.primary,
                shadows: [Shadow(color: Colors.white)],
              ),
            ),
          ],
        ),

        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText("Lionel Messi", size: 16, isBold: true),
              Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.orange),
                  SizedBox(width: 4),
                  CommonText("4.9", size: 12),
                ],
              ),
              CommonText("\$280", size: 16, isBold: true),
            ],
          ),
        ),
        Card(
          elevation: 2,
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.email, color: AppColors.primary),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DriverProfilePageWhenOthersVisitsPage();
                },
              ),
            );
          },
          child: Card(
            elevation: 2,
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.person_2, color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }

  /// Vertical Stepper
  Widget _verticalStepper() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            children: [
              _stepDot(isActive: true),
              _stepLine(),
              _stepLocation(isActive: false),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _stepText(title: "From", value: "Morelia, Avenida P. Calle 12"),
              SizedBox(height: 10.h),
              _stepText(title: "To", value: "Morelia, Avenida P. Calle 12"),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.grey.withOpacity(.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: CommonText("3h 30m", size: 10),
        ),
      ],
    );
  }

  Widget _stepDot({required bool isActive}) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: isActive ? 7 : 2.5),
      ),
    );
  }

  Widget _stepLocation({required bool isActive}) {
    return Icon(isActive ? Icons.location_on : Icons.location_on_outlined);
  }

  Widget _stepLine() {
    return Container(width: 2, height: 40, color: Colors.grey);
  }

  Widget _stepText({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(title, size: 11, color: Colors.grey),
        SizedBox(height: 2),
        CommonText(value, size: 13, isBold: true),
      ],
    );
  }
}
