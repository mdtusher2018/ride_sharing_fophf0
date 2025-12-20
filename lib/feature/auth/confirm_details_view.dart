import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velozaje/feature/auth/register_vehicale_view.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text_field_with_title.dart';
import 'package:velozaje/res/common_text.dart';

class ConfirmDetailsPage extends StatefulWidget {
  const ConfirmDetailsPage({super.key});

  @override
  State<ConfirmDetailsPage> createState() => _ConfirmDetailsPageState();
}

class _ConfirmDetailsPageState extends State<ConfirmDetailsPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  File? _avatarImage;
  final ImagePicker _picker = ImagePicker();

  /// Pick avatar image from gallery
  Future<void> _pickAvatar() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
      });
    }
  }

  /// Pick date of birth
  Future<void> _pickDOB() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(dobController.text) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      dobController.text =
          '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: CommonText('Confirm Your Details', size: 21),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          children: [
            /// Circular avatar with border and camera icon
            GestureDetector(
              onTap: _pickAvatar,
              child: Stack(
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(color: AppColors.white, width: 1),
                    ),
                    child: ClipOval(
                      child: _avatarImage != null
                          ? Image.file(
                              _avatarImage!,
                              width: 100.w,
                              height: 100.w,
                              fit: BoxFit.cover,
                            )
                          : CommonImage(
                              path:
                                  "https://static.vecteezy.com/system/resources/previews/002/002/403/non_2x/man-with-beard-avatar-character-isolated-icon-free-vector.jpg",

                              width: 80.w,
                              sourceType: ImageSourceType.network,
                              height: 80.w,
                            ),
                    ),
                  ),
                  // Camera icon overlay
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30.w,
                      height: 30.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            /// Email field
            CommonTextfieldWithTitle(
              'Email',
              emailController,
              hintText: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              prefixIconWidget: Padding(
                padding: EdgeInsets.all(12.r),
                child: Icon(Icons.email, color: Colors.grey, size: 20.sp),
              ),
            ),
            SizedBox(height: 16.h),

            /// Contact Phone field
            CommonTextfieldWithTitle(
              'Contact Phone',
              phoneController,
              hintText: 'Enter your contact number',
              keyboardType: TextInputType.phone,
              prefixIconWidget: Padding(
                padding: EdgeInsets.all(12.r),
                child: Icon(Icons.phone, color: Colors.grey, size: 20.sp),
              ),
            ),
            SizedBox(height: 16.h),

            /// Full Name field
            CommonTextfieldWithTitle(
              'Full Name',
              fullNameController,
              hintText: 'Enter your full name',
              prefixIconWidget: Padding(
                padding: EdgeInsets.all(12.r),
                child: Icon(Icons.person, color: Colors.grey, size: 20.sp),
              ),
            ),
            SizedBox(height: 16.h),

            /// Address field
            CommonTextfieldWithTitle(
              'Address',
              addressController,
              hintText: 'Enter your address',
              prefixIconWidget: Padding(
                padding: EdgeInsets.all(12.r),
                child: Icon(Icons.location_on, color: Colors.grey, size: 20.sp),
              ),
            ),
            SizedBox(height: 16.h),

            /// DOB field - pickable
            CommonTextfieldWithTitle(
              'DOB',
              dobController,
              hintText: 'Select your date of birth',
              keyboardType: TextInputType.none,
              enable: false,
              onTap: _pickDOB,
              prefixIconWidget: Padding(
                padding: EdgeInsets.all(12.r),
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.grey,
                  size: 20.sp,
                ),
              ),
            ),

            SizedBox(height: 40.h),

            /// Confirm Button
            CommonButton(
              "Confirm Data",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RegisterVehiclePage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
