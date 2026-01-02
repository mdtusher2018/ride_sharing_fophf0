import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/feature/result_and_booking/widget/driver_result_card.dart';
import 'package:velozaje/feature/result_and_booking/widget/filter_widget.dart';
import 'package:velozaje/res/common_appbar.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbg,
      appBar: commonAppBar(
        context,
        title: AppLocalizations.of(context)!.results,
        actionWidget: InkWell(
          onTap: () {
            showFilterBottomSheet(context);
          },
          child: Icon(Icons.filter_alt_rounded),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16);
                },

                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return DriverResultCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
