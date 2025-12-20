// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:velozaje/utills/app_colors.dart';

import 'package:velozaje/res/common_text.dart';

class TipHeaderCard extends StatelessWidget {
  TipHeaderCard({super.key, required this.isTripStartPage});

  final bool isTripStartPage;

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
          securityHandShake(),
          SizedBox(height: 12.h),
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

  Widget securityHandShake() {
    final int length = 4;

    List<TextEditingController> controllers = List.generate(
      length,
      (_) => TextEditingController(),
    );
    List<FocusNode> focusNodes = List.generate(length, (_) => FocusNode());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes.first.requestFocus();
    });

    return Container(
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: AppColors.grey,
                  size: 20,
                ),
                CommonText(
                  'Security Handshake',
                  color: AppColors.textSecondary,
                ),
              ],
            ),

            Divider(),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        CommonText('START CODE', color: AppColors.white),
                        Stack(
                          alignment: AlignmentGeometry.center,
                          children: [
                            CommonText(
                              '4 9 2 1',
                              size: 18,

                              color: AppColors.textSecondary,
                              isBold: true,
                            ),

                            Container(
                              height: 2,
                              color: AppColors.textSecondary,
                              width: 60.sp,
                            ),
                          ],
                        ),
                        CommonText('Give at Pickup', color: AppColors.grey),
                      ],
                    ),
                  ),
                ),
                Container(height: 60, width: 1, color: AppColors.grey),
                Expanded(
                  child: Column(
                    spacing: 8.h,
                    children: [
                      CommonText('END CODE', size: 12, color: Colors.white),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          4,
                          (index) => isTripStartPage
                              ? FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    child: TextField(
                                      maxLength: 1,
                                      controller: controllers[index],
                                      focusNode: focusNodes[index],
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        counterText: '',
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          if (index < length - 1) {
                                            focusNodes[index + 1]
                                                .requestFocus();
                                          } else {
                                            focusNodes[index].unfocus();
                                          }
                                        } else {
                                          if (index > 0) {
                                            focusNodes[index - 1]
                                                .requestFocus();
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.all(4),
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 2,
                                      color: AppColors.primary,
                                    ),
                                  ),

                                  child: Icon(Icons.lock_outline),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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
        Card(
          elevation: 2,
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.person_2, color: AppColors.primary),
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
