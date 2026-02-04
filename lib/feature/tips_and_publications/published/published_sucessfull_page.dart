import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/feature/root_view.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class PublishedSucessfullPage extends StatelessWidget {
  const PublishedSucessfullPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(16.r),
        child: Column(
          children: [
            Spacer(),
            CommonImage(
              path: "assest/image/compleate.png",
              width: 250,
              height: 250,
              sourceType: ImageSourceType.asset,
            ),

            SizedBox(
              height: 60,
              child: FittedBox(
                child: CommonText(
                  AppLocalizations.of(context)!.trip_published,
                  size: 24,
                  isBold: true,
                ),
              ),
            ),
            CommonText(
              AppLocalizations.of(
                context,
              )!.passengers_can_now_book_your_ride_to_madrid,
              size: 14,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 20.h),
            CommonButton(
              AppLocalizations.of(context)!.view_my_trips,
              onTap: () {
                RootPage.currentIndex = 2;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RootPage();
                    },
                  ),
                  (route) => false, // This will remove all previous routes
                );
              },
            ),

            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
