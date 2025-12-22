import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_text_field_with_title.dart';
import 'package:velozaje/utills/app_colors.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  // Controllers for text fields
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Password visibility toggles
  bool isCurrentPasswordVisible = true;
  bool isNewPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  // Form validation keys
  final _formKey = GlobalKey<FormState>();

  // Function to handle password update logic
  void _updatePassword() {
    if (_formKey.currentState!.validate()) {
      // Assuming a successful password update
      Navigator.pop(context); // Go back after updating password
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        title: "Change Password",
        backgroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: ListView(
          children: [
            // Current Password Field
            CommonTextfieldWithTitle(
              '',
              currentPasswordController,
              hintText: 'Enter your current password',

              issuffixIconVisible: true,
              isPasswordVisible: isCurrentPasswordVisible,
              changePasswordVisibility: () {
                setState(() {
                  isCurrentPasswordVisible = !isCurrentPasswordVisible;
                });
              },
            ),

            // New Password Field
            CommonTextfieldWithTitle(
              '',
              newPasswordController,
              hintText: 'Enter your new password',
              issuffixIconVisible: true,
              isPasswordVisible: isNewPasswordVisible,
              changePasswordVisibility: () {
                setState(() {
                  isNewPasswordVisible = !isNewPasswordVisible;
                });
              },
            ),

            // Confirm New Password Field
            CommonTextfieldWithTitle(
              "",
              confirmPasswordController,
              hintText: 'Re-enter your new password',
              issuffixIconVisible: true,
              isPasswordVisible: isConfirmPasswordVisible,
              changePasswordVisibility: () {
                setState(() {
                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                });
              },
            ),
            SizedBox(height: 30.h),

            // Update Button
            CommonButton(
              "Update",
              onTap:
                  _updatePassword, // Call _updatePassword method on button tap
            ),
          ],
        ),
      ),
    );
  }
}
