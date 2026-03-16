import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/feature/auth/view/referal_view.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text_field_with_title.dart';
import 'package:velozaje/res/common_text.dart';

class RegisterVehiclePage extends ConsumerStatefulWidget {
  const RegisterVehiclePage({super.key});

  @override
  ConsumerState<RegisterVehiclePage> createState() =>
      _RegisterVehiclePageState();
}

class _RegisterVehiclePageState extends ConsumerState<RegisterVehiclePage> {
  File? _vehicleImage;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController registrationController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final List<Map<String, String>> vehicleImage = [
    {'vehicleType': 'sedan', 'vehicleImage': 'assest/image/car.png'},
    {'vehicleType': 'suv', 'vehicleImage': 'assest/image/taxi.png'},
    {'vehicleType': 'bike', 'vehicleImage': 'assest/image/bike.png'},
    {'vehicleType': 'van', 'vehicleImage': 'assest/image/truck.png'},
  ];

  int selectedTypeIndex = 0;

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
        title: CommonText(
          AppLocalizations.of(context)!.register_your_vehicle,
          size: 21,
          isBold: true,
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ReferalPage()),
              );
            },
            child: CommonText(AppLocalizations.of(context)!.skip),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                AppLocalizations.of(
                                  context,
                                )!.upload_your_vehicle_image,
                                size: 12,
                                color: AppColors.grey,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            CommonText(
              AppLocalizations.of(context)!.select_vehicle_type,
              size: 14,
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
                          path: vehicleImage[index]['vehicleImage'],
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

            CommonTextfieldWithTitle(
              AppLocalizations.of(context)!.registration,
              registrationController,
              hintText: AppLocalizations.of(context)!.enter_registration_number,
            ),
            SizedBox(height: 16.h),

            /// Year of Vehicle
            CommonTextfieldWithTitle(
              AppLocalizations.of(context)!.year_of_vehicle,
              yearController,
              hintText: AppLocalizations.of(context)!.enter_year,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.h),

            /// Brand
            CommonTextfieldWithTitle(
              AppLocalizations.of(context)!.brand,
              brandController,
              hintText: AppLocalizations.of(context)!.enter_brand,
            ),
            SizedBox(height: 16.h),

            /// Model
            CommonTextfieldWithTitle(
              AppLocalizations.of(context)!.model,
              modelController,
              hintText: AppLocalizations.of(context)!.enter_model,
            ),
            SizedBox(height: 16.h),

            /// Car License plate number
            CommonTextfieldWithTitle(
              AppLocalizations.of(context)!.vehicle_license_plate_number,
              licenseController,
              hintText: AppLocalizations.of(context)!.enter_license_number,
            ),

            SizedBox(height: 40.h),

            ValueListenableBuilder(
              valueListenable: ref
                  .watch(vehicaleControllerProvider.notifier)
                  .isLoading,
              builder: (context, value, child) {
                return CommonButton(
                  AppLocalizations.of(context)!.confirm_data,
                  isLoading: value,
                  onTap: () async {
                    final success = await ref
                        .read(vehicaleControllerProvider.notifier)
                        .registerVehicale(
                          vehicleType:
                              vehicleImage[selectedTypeIndex]['vehicleType']!,
                          registration: registrationController.text.trim(),
                          year: yearController.text.trim(),
                          brand: brandController.text.trim(),
                          vehicleModel: modelController.text.trim(),
                          licensePlateNumber: licenseController.text.trim(),
                          image: _vehicleImage,
                        );

                    if (success == true && mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ReferalPage()),
                      );
                    }
                  },
                );
              },
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
