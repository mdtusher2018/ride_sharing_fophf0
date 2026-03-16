// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velozaje/controllers/profile_controller.dart';
import 'package:velozaje/controllers/trip/trips_book_controller.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/core/utils/helper.dart';
import 'package:velozaje/core/utils/map_helper.dart';
import 'package:velozaje/feature/chat/chat_view.dart';
import 'package:velozaje/feature/profile_and_account/driver_profile_view.dart';
import 'package:velozaje/feature/report_and_feedback/feed_back_bottom_sheet.dart';
import 'package:velozaje/feature/widget/back_button.dart';
import 'package:velozaje/feature/widget/map_widget.dart';
import 'package:velozaje/feature/widget/vehicale_card.dart';
import 'package:velozaje/models/response/trip/booking_details_response.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

part 'booked_tip_header_card.dart';

class BookedTipDetailsView extends ConsumerStatefulWidget {
  final String bookingId;
  final String tripId;
  const BookedTipDetailsView({
    super.key,
    required this.bookingId,
    required this.tripId,
  });

  @override
  ConsumerState<BookedTipDetailsView> createState() =>
      _BookedTipDetailsViewState();
}

class _BookedTipDetailsViewState extends ConsumerState<BookedTipDetailsView> {
  GoogleMapController? _mapController;
  Set<Polyline>? polylines;

  Future<Marker?> _buildDriverMarker(LatLng? location) async {
    if (location == null) return null;

    final icon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      'assest/image/car_in_map.png', // 🚗 your custom car image
    );

    return Marker(
      markerId: const MarkerId('driver_location'),
      position: location,
      icon: icon,
      infoWindow: const InfoWindow(title: 'Driver'),
      anchor: const Offset(0.5, 0.5), // ✅ centers the icon on the point
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref
          .read(tripsBookingControllerProvider.notifier)
          .bookedTripDetailsById(id: widget.bookingId);
      ref
          .read(passengerTripsControllerProvider.notifier)
          .getTripDetails(tripId: widget.tripId);
      final userId = await ref
          .read(profileControllerProvider.notifier)
          .getUserId();
      if (userId == null) return;
      ref
          .read(tripsBookingControllerProvider.notifier)
          .joinTripRoom(bookingId: widget.bookingId, userId: userId);
    });
  }

  Future<void> _drawRoutesIfReady(PassengerBookingDetailsModel booking) async {
    if (_mapController == null) return;

    // Call your helper to get the route
    final result = await MapHelper.drawRoutes(
      origin: LatLng(
        booking.pickupLocation.coordinates.latitude,
        booking.pickupLocation.coordinates.longitude,
      ),
      destination: LatLng(
        booking.dropoffLocation.coordinates.latitude,
        booking.dropoffLocation.coordinates.longitude,
      ),
      color: AppColors.primary,
    );

    if (result.polylines.isEmpty || result.routes.isEmpty) return;

    // Update your state with the polylines from the result
    setState(() {
      polylines = result.polylines;
    });

    // Fit map bounds to the first route
    MapHelper.fitBounds(result.polylines.first.points, _mapController!);
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(tripsBookingControllerProvider.notifier);
    final bookingState = ref.watch(tripsBookingControllerProvider);
    final passengerController = ref.watch(
      passengerTripsControllerProvider.notifier,
    );
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.3,
            child: Stack(
              children: [
                ValueListenableBuilder(
                  valueListenable: ref
                      .watch(tripsBookingControllerProvider.notifier)
                      .isLoading,
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
                    if (bookingDetails.id != widget.bookingId) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return FutureBuilder<Marker?>(
                      future: _buildDriverMarker(
                        (bookingState.extraState as TripsBookingState)
                            .driverCurrentLocation,
                      ),
                      builder: (context, snapshot) {
                        return ReusableMapWidget(
                          context: context,
                          destinationLocation: LatLng(
                            bookingDetails.dropoffLocation.coordinates.latitude,
                            bookingDetails
                                .dropoffLocation
                                .coordinates
                                .longitude,
                          ),
                          pickupLocation: LatLng(
                            bookingDetails.pickupLocation.coordinates.latitude,
                            bookingDetails.pickupLocation.coordinates.longitude,
                          ),
                          // ✅ Use the marker from FutureBuilder
                          additionalCustomMarkets: [
                            if (snapshot.data != null) snapshot.data!,
                          ],
                          onMapCreated: (controller) {
                            _mapController = controller;
                            _drawRoutesIfReady(bookingDetails);
                          },
                          polylines: polylines,
                        );
                      },
                    );
                  },
                ),
                Positioned(top: 48, left: 24, child: CommonBackButton()),
              ],
            ),
          ),

          Container(
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
                if (bookingDetails.id != widget.bookingId) {
                  return Center(child: CircularProgressIndicator());
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref
                        .read(tripsBookingControllerProvider.notifier)
                        .bookedTripDetailsById(id: widget.bookingId);
                    ref
                        .read(passengerTripsControllerProvider.notifier)
                        .getTripDetails(tripId: widget.tripId);
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
                              year: bookingDetails.trip.vehicle.year.toString(),
                            ),
                            SizedBox(height: 16.h),

                            ValueListenableBuilder(
                              valueListenable: passengerController.isLoading,
                              builder: (context, value, child) {
                                if (value) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (passengerController.tripDetails == null) {
                                  return Center(
                                    child: CommonText(
                                      "Faield to fetch Passenger details",
                                    ),
                                  );
                                }

                                final passengers = passengerController
                                    .tripDetails!
                                    .data
                                    .passengers;
                                if (passengers.isEmpty) return SizedBox();
                                return Card(
                                  color: AppColors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        CommonText(
                                          AppLocalizations.of(
                                            context,
                                          )!.passengers,
                                          size: 16,
                                          isBold: true,
                                        ),
                                        SizedBox(height: 8.h),
                                        Column(
                                          children: List.generate(passengers.length, (
                                            index,
                                          ) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 8,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CommonImage(
                                                    path: passengers[index]
                                                        .passenger
                                                        .image,
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                    sourceType:
                                                        ImageSourceType.network,
                                                  ),
                                                  SizedBox(width: 12),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CommonText(
                                                          passengers[index]
                                                              .passenger
                                                              .fullName,
                                                          size: 14,
                                                          maxline: 1,
                                                          isBold: true,
                                                        ),

                                                        // Subtitle row with rating
                                                        CommonText(
                                                          "Booked at: ${formatDateTime(passengers[index].bookedAt)}",
                                                          maxline: 1,
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
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                            SizedBox(height: 16.h),
                            if (bookingDetails.status ==
                                BookingStatus.completed)
                              CommonButton(
                                AppLocalizations.of(context)!.rate_your_driver,
                                color: AppColors.primary,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return RateDriverBottomSheet(
                                        bookingId: bookingDetails.id,
                                        driverName:
                                            bookingDetails.driver.fullName,
                                        image:
                                            bookingDetails.driver.image ?? "",
                                      );
                                    },
                                  );
                                },
                              ),
                            if (bookingDetails.status !=
                                    BookingStatus.completed &&
                                bookingDetails.status !=
                                    BookingStatus.cancelled)
                              CommonButton(
                                AppLocalizations.of(context)!.cancel_trip,
                                color: AppColors.error,
                                onTap: () => showCancelRideSheet(
                                  context,
                                  bookingId: bookingDetails.id,
                                ),
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
        ],
      ),
    );
  }

  void showCancelRideSheet(BuildContext context, {required String bookingId}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => CancelRideBottomSheet(bookingId: bookingId),
    );
  }
}

class CancelRideBottomSheet extends ConsumerStatefulWidget {
  final String bookingId;
  const CancelRideBottomSheet({super.key, required this.bookingId});

  @override
  ConsumerState<CancelRideBottomSheet> createState() =>
      _CancelRideBottomSheetState();
}

class _CancelRideBottomSheetState extends ConsumerState<CancelRideBottomSheet> {
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
              size: 18,
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
                ref
                    .read(tripsBookingControllerProvider.notifier)
                    .cancelBookingByUser(
                      bookingId: widget.bookingId,
                      reason: reasons[selectedIndex],
                    );
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
