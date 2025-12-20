import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text_field_with_title.dart';
import 'package:velozaje/res/common_text.dart';

class RegisterVehiclePage extends StatefulWidget {
  const RegisterVehiclePage({super.key});

  @override
  State<RegisterVehiclePage> createState() => _RegisterVehiclePageState();
}

class _RegisterVehiclePageState extends State<RegisterVehiclePage> {
  File? _vehicleImage;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController registrationController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();

  final List<String> vehicleImage = [
    'assest/image/car.png',
    'assest/image/taxi.png',
    'assest/image/bike.png',
    'assest/image/truck.png',
  ];
  int selectedTypeIndex = 0;

  /// Pick vehicle image
  Future<void> _pickVehicleImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _vehicleImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: CommonText('Register Your Vehicle', size: 21, isBold: true),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Vehicle Image Upload
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: _pickVehicleImage,
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  dashPattern: [6, 8],
                  color: Colors.grey,
                  stackFit: StackFit.loose,
                  strokeCap: StrokeCap.round,
                  radius: Radius.circular(10),
                  strokeWidth: 3,
                ),

                child: Container(
                  width: double.infinity,
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: AppColors.grey.withOpacity(0.1),
                  ),
                  child: _vehicleImage != null
                      ? Image.file(
                          _vehicleImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload,
                                size: 80.sp,
                                color: AppColors.grey,
                              ),
                              SizedBox(height: 8.h),
                              CommonText(
                                '*Upload your vehicle image',
                                size: 12.sp,
                                color: AppColors.grey,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            /// Vehicle Type Selection
            CommonText(
              'Select Vehicle Type',
              size: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: vehicleImage.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedTypeIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTypeIndex = index;
                      });
                    },
                    child: Container(
                      width: 90,
                      margin: EdgeInsets.only(right: 12.w),
                      decoration: BoxDecoration(
                        color: AppColors.mainbg,
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
                          width: 50,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 24.h),

            /// Registration
            CommonTextfieldWithTitle(
              'Registration',
              registrationController,
              hintText: 'Enter registration number',
            ),
            SizedBox(height: 16.h),

            /// Year of Vehicle
            CommonTextfieldWithTitle(
              'Year of Vehicle',
              yearController,
              hintText: 'Enter year',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.h),

            /// Brand
            CommonTextfieldWithTitle(
              'Brand',
              brandController,
              hintText: 'Enter brand',
            ),
            SizedBox(height: 16.h),

            /// Model
            CommonTextfieldWithTitle(
              'Model',
              modelController,
              hintText: 'Enter model',
            ),
            SizedBox(height: 16.h),

            /// Car License plate number
            CommonTextfieldWithTitle(
              'Car License Plate Number',
              licenseController,
              hintText: 'Enter license number',
            ),

            SizedBox(height: 40.h),

            /// Confirm Button
            CommonButton(
              'Confirm Data',
              onTap: () {
                // TODO: Add confirmation logic
              },
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
