import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/models/request/trip_search_request.dart';
import 'package:velozaje/models/response/trip/passenger_trip_model.dart';
import 'package:velozaje/res/common_button.dart';

class TripBookingConfirmView extends ConsumerWidget {
  final File imageFile;
  final PassengerTripModel tripDetails;
  final TripSearchRequest tripSearched;
  final VoidCallback? onBooking;

  const TripBookingConfirmView({
    super.key,
    required this.imageFile,
    required this.onBooking,
    required this.tripDetails,
    required this.tripSearched,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(tripsBookingControllerProvider.notifier);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(imageFile, fit: BoxFit.cover),

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

          Positioned(
            bottom: 60,
            left: 32,
            right: 32,
            child: ValueListenableBuilder(
              valueListenable: controller.isLoading,
              builder: (context, value, child) {
                return CommonButton(
                  AppLocalizations.of(context)!.confirm_booking,
                  isLoading: value,
                  onTap: () async {
                    final success = await controller.tripBooking(
                      passengerImage: imageFile,
                      tripDetails: tripDetails,
                      tripSearched: tripSearched,
                    );

                    if (success == true) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      if (onBooking != null) onBooking!();
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
