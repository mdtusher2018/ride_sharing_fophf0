import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/tips_and_publications/published/published_sucessfull_page.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_button.dart';

class PublishConfirmPage extends StatelessWidget {
  final File imageFile;

  const PublishConfirmPage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// Image Preview
          Image.file(imageFile, fit: BoxFit.cover),

          /// Back Button
          Positioned(
            top: 50.h,
            left: 16.w,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          /// Bottom Action Panel
          Positioned(
            bottom: 60,
            left: 32,
            right: 32,
            child: CommonButton(
              "Publish Trip",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PublishedSucessfullPage();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
