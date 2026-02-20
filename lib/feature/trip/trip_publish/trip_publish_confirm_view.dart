import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/feature/trip/trip_publish/trip_published_sucessfull_view.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/models/request/trip_publish_request.dart';
import 'package:velozaje/res/common_button.dart';

class TripPublishConfirmView extends ConsumerWidget {
  final TripPublishRequest publishedData;

  const TripPublishConfirmView({super.key, required this.publishedData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// Image Preview
          Image.file(publishedData.driverImage!, fit: BoxFit.cover),

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
            child: ValueListenableBuilder(
              valueListenable: ref
                  .watch(tripsPublishControllerProvider.notifier)
                  .isLoading,
              builder: (context, value, child) {
                return CommonButton(
                  AppLocalizations.of(context)!.publish_trip,
                  onTap: () async {
                    final result = await ref
                        .read(tripsPublishControllerProvider.notifier)
                        .publishTrip(publishedData: publishedData);
                    if (result ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TripPublishedSucessfullView();
                          },
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
