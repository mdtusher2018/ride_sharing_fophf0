// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/core/utils/helper.dart';
import 'package:velozaje/feature/widget/back_button.dart';
import 'package:velozaje/feature/widget/vehicale_card.dart';
import 'package:velozaje/models/response/trip/booking_details_response.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

part '../parts/booking_tip_header_card.dart';

class BookedTipDetailsView extends ConsumerStatefulWidget {
  final String id;
  const BookedTipDetailsView({super.key, required this.id});

  @override
  ConsumerState<BookedTipDetailsView> createState() =>
      _BookedTipDetailsViewState();
}

class _BookedTipDetailsViewState extends ConsumerState<BookedTipDetailsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(tripsBookingControllerProvider.notifier)
          .bookedTripDetailsById(id: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(tripsBookingControllerProvider.notifier);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.grey,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: CommonImage(
              path: "https://i.sstatic.net/HILmr.png",
              sourceType: ImageSourceType.network,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 48.h,
            left: 24.w,
            child: InkWell(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: CommonBackButton(),
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(16.w),

              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.7,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: ValueListenableBuilder(
                valueListenable: controller.isLoading,
                builder: (_, isLoading, _) {
                  if (isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (!isLoading && controller.bookingDetail == null) {
                    return Center(
                      child: CommonText("Couldnot featch the details"),
                    );
                  }
                  final PassengerBookingDetailsModel bookingDetails =
                      controller.bookingDetail!;
                  if (bookingDetails.id != widget.id) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      ref
                          .read(tripsBookingControllerProvider.notifier)
                          .bookedTripDetailsById(id: widget.id);
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            width: 40.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),

                          SizedBox(height: 12.h),
                          Column(
                            children: [
                              TipHeaderCard(bookingDetails: bookingDetails),
                              SizedBox(height: 16.h),
                              VehicleCard(
                                brand: bookingDetails.trip.vehicle.brand,
                                image: bookingDetails
                                    .trip
                                    .vehicle
                                    .vehicleImages
                                    .first,
                                licensePlateNumber: bookingDetails
                                    .trip
                                    .vehicle
                                    .licensePlateNumber,
                                vehicleModel:
                                    bookingDetails.trip.vehicle.vehicleModel,
                                year: bookingDetails.trip.vehicle.year
                                    .toString(),
                              ),
                              SizedBox(height: 16.h),

                              Card(
                                color: AppColors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CommonText(
                                        AppLocalizations.of(
                                          context,
                                        )!.passengers,
                                        size: 16,
                                        isBold: true,
                                      ),
                                      SizedBox(height: 8.h),

                                      ...List.generate(4, (index) {
                                        return InkWell(
                                          onTap: () {},
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Leading image container
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  margin: EdgeInsets.only(
                                                    right: 10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        "https://randomuser.me/api/portraits/men/32.jpg",
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                ),

                                                // Title and Subtitle section
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Title text
                                                      CommonText(
                                                        "text",
                                                        size: 14,
                                                        isBold: true,
                                                      ),

                                                      // Subtitle row with rating
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color:
                                                                Colors.orange,
                                                            size: 16,
                                                          ),
                                                          SizedBox(width: 8),
                                                          CommonText("4.9"),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                // Trailing arrow icon
                                                Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  size: 16,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                spacing: 16.w,
                                children: [
                                  Expanded(
                                    child: CommonButton(
                                      AppLocalizations.of(context)!.claim,
                                      color: Colors.transparent,
                                      boarder: Border.all(
                                        color: AppColors.error,
                                      ),

                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) {
                                        //       return StartTipDetailsPage();
                                        //     },
                                        //   ),
                                        // );
                                      },

                                      iconWidget: Icon(
                                        Icons.warning_amber,
                                        color: AppColors.error,
                                      ),
                                      textColor: AppColors.error,
                                    ),
                                  ),
                                  Expanded(
                                    child: CommonButton(
                                      AppLocalizations.of(context)!.cancel_trip,
                                      color: AppColors.error,
                                      onTap: () => showCancelRideSheet(context),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40.h),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCancelRideSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const CancelRideBottomSheet(),
    );
  }
}

class CancelRideBottomSheet extends StatefulWidget {
  const CancelRideBottomSheet({super.key});

  @override
  State<CancelRideBottomSheet> createState() => _CancelRideBottomSheetState();
}

class _CancelRideBottomSheetState extends State<CancelRideBottomSheet> {
  int selectedIndex = 0;

  final List<String> reasons = [
    'Select wrong dropoff',
    'Selected wrong pickup',
    'Selected wrong vehicle',
    'Wait time was too long',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            SizedBox(height: 16.h),

            CommonText(
              AppLocalizations.of(context)!.cancel_ride,
              size: 18.sp,
              fontWeight: FontWeight.w600,
            ),

            SizedBox(height: 16.h),

            /// Reasons
            ...List.generate(
              reasons.length,
              (index) => _ReasonTile(
                title: reasons[index],
                isSelected: selectedIndex == index,
                onTap: () {
                  setState(() => selectedIndex = index);
                },
              ),
            ),

            SizedBox(height: 20.h),

            /// Keep Trip
            CommonButton(
              AppLocalizations.of(context)!.keep_my_trip,
              color: Colors.green,
              textColor: Colors.white,
              textalign: TextAlign.center,
              height: 48,
              onTap: () => Navigator.pop(context),
            ),

            SizedBox(height: 12.h),

            /// Cancel Ride
            CommonButton(
              AppLocalizations.of(context)!.cancel_ride,
              color: Colors.transparent,
              textColor: Colors.black,
              boarder: Border.all(color: Colors.red, width: 2),
              onTap: () {
                // TODO: handle cancellation with reason
                Navigator.pop(context);
              },
            ),

            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

class _ReasonTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ReasonTile({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected ? Colors.green : Colors.grey,
                  width: 1.5,
                ),
                color: isSelected ? Colors.green : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CommonText(title, size: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
