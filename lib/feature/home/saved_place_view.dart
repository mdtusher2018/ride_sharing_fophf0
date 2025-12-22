import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/home/widgets/saved_place_card.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/utills/app_colors.dart';

class SavedPlacePage extends StatelessWidget {
  const SavedPlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Saved Places"),
      backgroundColor: AppColors.mainbg,
      body: Padding(
        padding: EdgeInsetsGeometry.all(16.r),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.h);
          },
          itemCount: 10,
          itemBuilder: (context, index) {
            return savedPlaceCard(issBookMarks: true);
          },
        ),
      ),
    );
  }
}
