import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/services/providers.dart';
import 'package:velozaje/core/utils/helper.dart';
import 'package:velozaje/feature/result_and_booking/confirm_booking_page.dart';
import 'package:velozaje/feature/result_and_booking/driver_profile_when_others_visit_page.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/feature/widget/vehicale_card.dart';
import 'package:velozaje/models/response/trip/passenger_trip_model.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class PassengerTripDetailsPage extends ConsumerStatefulWidget {
  final String tripId;
  const PassengerTripDetailsPage({super.key, required this.tripId});

  @override
  ConsumerState<PassengerTripDetailsPage> createState() =>
      _PassengerTripDetailsPageState();
}

class _PassengerTripDetailsPageState
    extends ConsumerState<PassengerTripDetailsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(passengerTripsControllerProvider.notifier)
          .getTripDetails(tripId: widget.tripId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(passengerTripsControllerProvider.notifier);
    return Scaffold(
      appBar: commonAppBar(context, title: AppLocalizations.of(context)!.trip),
      backgroundColor: AppColors.mainbg,
      body: ValueListenableBuilder(
        valueListenable: controller.isLoading,
        builder: (context, value, child) {
          if (value) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.tripDetails == null) {
            return Center(child: CommonText("Faield to fetch Trip details"));
          }
          final trip = controller.tripDetails!.data.trip;
          final passengers = controller.tripDetails!.data.passengers;
          return Padding(
            padding: EdgeInsets.all(16.r),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _HeaderCard(trip: trip),
                  SizedBox(height: 16.h),
                  VehicleCard(
                    image: trip.vehicle.vehicleImages.first,
                    brand: trip.vehicle.brand,
                    vehicleModel: trip.vehicle.vehicleModel,
                    year: trip.vehicle.year.toString(),
                    licensePlateNumber: trip.vehicle.licensePlateNumber,
                  ),
                  SizedBox(height: 16.h),

                  if (passengers.isNotEmpty)
                    Card(
                      color: AppColors.white,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CommonText(
                              AppLocalizations.of(context)!.passengers,
                              size: 16,
                              isBold: true,
                            ),
                            SizedBox(height: 8.h),

                            ...List.generate(passengers.length, (index) {
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CommonImage(
                                        path: passengers[index].passenger.image,
                                        width: 40,
                                        height: 40,
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                        Icons.arrow_forward_ios_outlined,
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
                  CommonButton(
                    AppLocalizations.of(context)!.see_on_map,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ConfirmBookingPage();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeaderCard extends StatefulWidget {
  final PassengerTripModel trip;
  const _HeaderCard({required this.trip});

  @override
  State<_HeaderCard> createState() => _HeaderCardState();
}

class _HeaderCardState extends State<_HeaderCard> {
  bool showPackageOptions = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _header(),
          SizedBox(height: 12.h),
          _verticalStepper(),
          SizedBox(height: 12.h),
          Divider(),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              AppLocalizations.of(context)!.trip_details,
              size: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              widget.trip.description,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Stack(
          children: [
            CommonImage(path: widget.trip.driverImage, width: 60, height: 60),
            Positioned(
              bottom: 0,
              right: 0,
              child: Icon(
                Icons.verified,
                color: AppColors.primary,
                shadows: [Shadow(color: Colors.white)],
              ),
            ),
          ],
        ),

        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                widget.trip.driver.fullName,
                size: 14,
                isBold: true,
                maxline: 1,
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.orange),
                  SizedBox(width: 4),
                  CommonText(
                    widget.trip.driver.ratting.toStringAsFixed(1),
                    size: 12,
                  ),
                ],
              ),
              CommonText(
                "\$${widget.trip.pricePerSeat.toInt()}",
                size: 16,
                isBold: true,
              ),
            ],
          ),
        ),
        Card(
          elevation: 2,
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.email, color: AppColors.primary),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DriverProfilePageWhenOthersVisitsPage();
                },
              ),
            );
          },
          child: Card(
            elevation: 2,
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.person_2, color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _verticalStepper() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            children: [
              _stepDot(isActive: true),
              _stepLine(),
              _stepLocation(isActive: false),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _stepText(
                title: AppLocalizations.of(context)!.from,
                value: widget.trip.pickupLocation.address,
              ),
              SizedBox(height: 10.h),
              _stepText(
                title: AppLocalizations.of(context)!.to,
                value: widget.trip.pickupLocation.address,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.grey.withOpacity(.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: CommonText(
            formatDurationInMinutes(widget.trip.estimatedDuration.toInt()),
            size: 10,
          ),
        ),
      ],
    );
  }

  Widget _stepDot({required bool isActive}) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: isActive ? 7 : 2.5),
      ),
    );
  }

  Widget _stepLocation({required bool isActive}) {
    return Icon(isActive ? Icons.location_on : Icons.location_on_outlined);
  }

  Widget _stepLine() {
    return Container(width: 2, height: 40, color: Colors.grey);
  }

  Widget _stepText({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(title, size: 11, color: Colors.grey),
        SizedBox(height: 2),
        CommonText(value, size: 12, isBold: true, maxline: 2),
      ],
    );
  }
}
