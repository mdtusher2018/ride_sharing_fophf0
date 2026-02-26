import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velozaje/controllers/trip/trips_book_controller.dart';
import 'package:velozaje/controllers/trip/trips_publish_controller.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/core/utils/helper.dart';
import 'package:velozaje/core/utils/map_helper.dart';
import 'package:velozaje/feature/widget/map_widget.dart';
import 'package:velozaje/feature/widget/vehicale_card.dart';
import 'package:velozaje/models/response/trip/passenger_trip_model.dart';
import 'package:velozaje/models/response/trip/published_trip_details_response.dart';
import 'package:velozaje/res/bottom_sheet_handeler.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_otp_field.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/core/utils/app_colors.dart';
part 'parts_of_trip_details/bottom_buttons.dart';
part 'parts_of_trip_details/trip_summary_card.dart';

class PublishedTripDetailsView extends ConsumerStatefulWidget {
  final String id;
  const PublishedTripDetailsView({super.key, required this.id});

  @override
  ConsumerState<PublishedTripDetailsView> createState() =>
      _MyPublishedDetailsPageState();
}

class _MyPublishedDetailsPageState
    extends ConsumerState<PublishedTripDetailsView> {
  @override
  void initState() {
    super.initState();

    loadInitialData();
  }

  GoogleMapController? _mapController;
  Set<Polyline>? polylines;

  void loadInitialData() async {
    final tripDetails = await ref
        .read(passengerTripsControllerProvider.notifier)
        .getTripDetails(tripId: widget.id);

    await ref
        .read(tripsPublishControllerProvider.notifier)
        .publishedTripDetailsById(id: widget.id, tripDetails: tripDetails);
    final publisheState =
        ref.watch(tripsPublishControllerProvider).extraState
            as TripsPublishState?;
    final bookingController = ref.read(tripsBookingControllerProvider.notifier);
    if (publisheState != null &&
        publisheState.bookingsOfPublishedTrip != null) {
      bookingController.initializedBookingsOfAPublishedTrips(
        pendingBookings: publisheState.bookingsOfPublishedTrip!.data.bookings
            .where((element) {
              return element.status == BookingStatus.pending;
            })
            .toList(),
        confirmedBookings: publisheState.bookingsOfPublishedTrip!.data.bookings
            .where((element) {
              return element.status != BookingStatus.pending;
            })
            .toList(),
      );
    }
  }

  Future<void> _drawRoutesIfReady(PassengerTripModel trip) async {
    if (_mapController == null) return;

    final encodedString = trip.routePolyline;
    // r'''anvwFhqobMwE{Co@Ui@DQZKD_B_A{B{AUz@y@bC_Qti@kCfIo@zBoIzWwAvEdPnKvAbArAx@fMhIJ\fCfBHR?\c@vAMN_@@wAeCi@o@_@Wk@Ia@Bm@Xi@f@o@dA}DhIwAjEa@fBk@rD_@rA}Uju@_Zh_Aa@bBUbBGxA@rANxA\vAf@nAx@hArBjBdCdBf@XNAvCnAvB~Al@Hx@Mh@Y^]Xc@VaAFgAEw@O{@]s@e@c@q@_@gCeAoEkA_Do@qC_@{@?u@Jy@X}@f@w@jA}@bC{HhU}FpR{A~D_GfOgDxJcBfGuC|KyB`JcEzOOF[bAm@rAm@`AaAfAuEvE}AhAkCxAqCbAoXdGgEvAcChAwCfBoA|@}BpBqAnAgBvBiBfCeb@np@qv@dkAYD{AhAsAb@i@H}ELa@O{BCoC@iBK}AY{A_@cEuA{EsBq@_@Q[GYB]jAiCz@a@~@EvCrAdHpCNLz@^VRR^Hf@CnAWpKBtBUf@[\qAA}@Q}@c@m@m@iDcFa@YQGsCbG]dA''';

    final decodedPoints = PolylinePoints.decodePolyline(encodedString);

    Set<Polyline> routePolyline;

    final result = await MapHelper.drawRoutes(
      origin: LatLng(
        trip.pickupLocation.coordinates.latitude,
        trip.pickupLocation.coordinates.longitude,
      ),
      color: AppColors.primary,
      destination: LatLng(
        trip.dropoffLocation.coordinates.latitude,
        trip.dropoffLocation.coordinates.longitude,
      ),
    );

    if (result.polylines.isEmpty || result.routes.isEmpty) return;

    routePolyline = result.polylines;

    int selectedIndex = -1;

    for (int i = 0; i < result.routes.length; i++) {
      log("Encoded String1 :${result.routes[i].polylineEncoded}\n");
      log("Encoded String2 : $encodedString\n\n\n");
      if (result.routes[i].polylineEncoded == encodedString) {
        log("==============>>>>>> matched");
        selectedIndex = i;
      }
    }

    if (selectedIndex == -1) {
      routePolyline = {
        Polyline(
          polylineId: const PolylineId('route'),
          color: Colors.blue,
          width: 4,
          points: decodedPoints.map((e) {
            return LatLng(e.latitude, e.longitude);
          }).toList(),
        ),
      };
    }
    final updatedPolylines = <Polyline>{};
    int i = 0;

    for (final poly in routePolyline) {
      updatedPolylines.add(
        poly.copyWith(
          colorParam: i == selectedIndex ? Colors.blue : Colors.transparent,
          widthParam: i == selectedIndex ? 7 : 4,
          zIndexParam: i == selectedIndex ? 2 : 1,
        ),
      );
      i++;
    }

    setState(() => polylines = updatedPolylines);

    MapHelper.fitBounds(result.polylines.first.points, _mapController!);
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(tripsBookingControllerProvider);

    final publisheState =
        ref.watch(tripsPublishControllerProvider).extraState
            as TripsPublishState?;

    return Scaffold(
      body: Column(
        children: [
          /// --------------------
          /// Map Placeholder
          /// --------------------
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.3,
            child: ValueListenableBuilder(
              valueListenable: ref
                  .watch(tripsPublishControllerProvider.notifier)
                  .isLoading,
              builder: (_, isLoading, _) {
                if (isLoading ||
                    widget.id != publisheState?.tripDetails?.data.trip.id) {
                  return Center(child: CircularProgressIndicator());
                } else if (publisheState == null ||
                    publisheState.bookingsOfPublishedTrip == null ||
                    publisheState.tripDetails == null) {
                  return const Center(
                    child: CommonText("Could not fetch details"),
                  );
                }
                final trip = publisheState.tripDetails!.data.trip;
                return ReusableMapWidget(
                  context: context,
                  destinationLocation: LatLng(
                    trip.dropoffLocation.coordinates.latitude,
                    trip.dropoffLocation.coordinates.longitude,
                  ),
                  pickupLocation: LatLng(
                    trip.pickupLocation.coordinates.latitude,
                    trip.pickupLocation.coordinates.longitude,
                  ),
                  onMapCreated: (controller) {
                    _mapController = controller;

                    _drawRoutesIfReady(trip);
                  },
                  polylines: polylines,
                );
              },
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
                color: AppColors.mainbg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: ValueListenableBuilder(
                valueListenable: ref
                    .watch(tripsPublishControllerProvider.notifier)
                    .isLoading,
                builder: (context, isLoading, child) {
                  if (isLoading ||
                      widget.id != publisheState?.tripDetails?.data.trip.id) {
                    return Center(child: CircularProgressIndicator());
                  } else if (publisheState == null ||
                      publisheState.bookingsOfPublishedTrip == null ||
                      publisheState.tripDetails == null) {
                    return const Center(
                      child: CommonText("Could not fetch details"),
                    );
                  }
                  final vehicle = publisheState.tripDetails!.data.trip.vehicle;
                  return RefreshIndicator(
                    onRefresh: () async {
                      loadInitialData();
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SheetHandle(),
                          SizedBox(height: 12.h),

                          CommonText(
                            AppLocalizations.of(context)!.trip_details,
                            size: 16,
                            fontWeight: FontWeight.w600,
                          ),

                          SizedBox(height: 16.h),

                          _TripSummaryCard(
                            trip: publisheState.tripDetails!.data.trip,
                          ),

                          SizedBox(height: 12.h),

                          VehicleCard(
                            brand: vehicle?.brand ?? "",
                            image: vehicle?.vehicleImages.first ?? "",
                            licensePlateNumber:
                                vehicle?.licensePlateNumber ?? "",
                            vehicleModel: vehicle?.vehicleModel ?? "",
                            year: vehicle?.year.toString() ?? "",
                          ),
                          SizedBox(height: 16.h),

                          Align(
                            alignment: AlignmentGeometry.centerLeft,
                            child: CommonText(
                              AppLocalizations.of(
                                context,
                              )!.confirmed_passengers,
                              size: 14,
                              isBold: true,
                            ),
                          ),

                          ...(bookingState.extraState as TripsBookingState)
                              .confirmedBookings
                              .map((e) {
                                return _PassengerCard(
                                  key: ValueKey(e.id),
                                  bookings: e,
                                  tripId: widget.id,
                                );
                              }),
                          SizedBox(height: 12.h),

                          Align(
                            alignment: AlignmentGeometry.centerLeft,
                            child: CommonText(
                              AppLocalizations.of(context)!.pending_requests_2,
                              size: 14,
                              isBold: true,
                            ),
                          ),
                          ...(bookingState.extraState as TripsBookingState)
                              .pendingBookings
                              .map((e) {
                                return _PassengerCard(
                                  key: ValueKey(e.id),
                                  bookings: e,
                                  tripId: widget.id,
                                );
                              }),

                          SizedBox(height: 20.h),

                          _BottomButtons(),
                          SizedBox(height: 20.h),
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
}

class _PassengerCard extends ConsumerStatefulWidget {
  final BookingsOfPublishedTrip bookings;
  final String tripId;

  const _PassengerCard({
    super.key,
    required this.bookings,
    required this.tripId,
  });

  @override
  ConsumerState<_PassengerCard> createState() => _PassengerCardState();
}

class _PassengerCardState extends ConsumerState<_PassengerCard> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, (_) => TextEditingController());
    focusNodes = List.generate(4, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10.h),

      color: AppColors.white,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            userInfo(context),
            SizedBox(height: 8),
            if (widget.bookings.status == BookingStatus.pending)
              pendingView(context, ref),
            if (widget.bookings.status == BookingStatus.confirmed)
              pickupCode(context, ref),
            // if (widget.bookings.status == BookingStatus.inProgress)
            //   onTheWay(ref),
            if (widget.bookings.status == BookingStatus.inProgress) finalCode(),
            if (widget.bookings.status == BookingStatus.completed)
              compleate(context),
          ],
        ),
      ),
    );
  }

  Widget userInfo(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(right: 6, bottom: 6),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: CommonImage(
                  path: widget.bookings.passengerImage,
                  width: 60,
                  height: 60,
                  sourceType: ImageSourceType.network,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Icon(Icons.verified, color: AppColors.primary),
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
                widget.bookings.passenger.fullName,
                size: 13,
                maxline: 1,
                isBold: true,
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.orange),
                  SizedBox(width: 4),
                  CommonText("4.9"),
                  SizedBox(width: 8),
                  if (widget.bookings.bookingType == BookingType.travel) ...[
                    Icon(Icons.group_outlined, size: 20),
                    SizedBox(width: 4),
                    CommonText(
                      "${widget.bookings.seatsBooked} ${AppLocalizations.of(context)!.seats}",
                    ),
                  ],
                ],
              ),
              CommonText(
                "\$${widget.bookings.totalPrice.toStringAsFixed(1)}",
                size: 14,
                isBold: true,
                color: AppColors.primary,
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
        Card(
          elevation: 2,
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.person_2, color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget pendingView(BuildContext context, WidgetRef ref, {required}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Icon(Icons.radio_button_checked, size: 14),
                SizedBox(height: 6),
                Container(width: 1, height: 30, color: AppColors.textPrimary),
                SizedBox(height: 6),
                Icon(Icons.location_on, size: 18),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    AppLocalizations.of(context)!.from,
                    size: 11,
                    color: Colors.grey,
                  ),
                  CommonText(
                    widget.bookings.pickupLocation.address,
                    size: 13,
                    maxline: 1,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 10.h),
                  CommonText(
                    AppLocalizations.of(context)!.to,
                    size: 11,
                    color: Colors.grey,
                  ),
                  CommonText(
                    widget.bookings.dropoffLocation.address,
                    size: 13,
                    maxline: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ],
        ),

        if (widget.bookings.bookingType == BookingType.package) ...[
          ListView.builder(
            itemCount: widget.bookings.packages.length,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Iconsax.box_1_outline,
                          color: AppColors.textSecondary,
                        ),
                        CommonText(
                          " ${index + 1}",
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),

                    CommonText(
                      "${widget.bookings.packages[index].dimensions.length}*${widget.bookings.packages[index].dimensions.width}*${widget.bookings.packages[index].dimensions.height} (${widget.bookings.packages[index].weight}kg)",
                      size: 14,
                      color: AppColors.textSecondary,
                    ),

                    CommonText(
                      "\$${widget.bookings.packages[index].price}",
                      color: AppColors.primary,
                      size: 14,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        SizedBox(height: 10.h),

        SizedBox(
          height: 35,
          child: Row(
            spacing: 8.w,
            children: [
              Expanded(
                child: CommonButton(
                  AppLocalizations.of(context)!.cancel_trip,
                  color: Colors.transparent,
                  textColor: Colors.red,

                  boarder: Border.all(color: Colors.red, width: 2),
                  onTap: () {
                    ref
                        .read(tripsBookingControllerProvider.notifier)
                        .rejectBookingById(bookingId: widget.bookings.id);
                  },
                  height: 20,
                  textSize: 12,
                  boarderRadious: 6,
                ),
              ),
              Expanded(
                child: CommonButton(
                  AppLocalizations.of(context)!.accept,
                  color: Colors.transparent,

                  textColor: Colors.green,
                  boarder: Border.all(color: Colors.green, width: 2),
                  onTap: () async {
                    await ref
                        .read(tripsBookingControllerProvider.notifier)
                        .acceptBookingById(bookingId: widget.bookings.id)
                        .then((value) async {
                          await ref
                              .read(tripsBookingControllerProvider.notifier)
                              .bookedTripDetailsById(id: widget.bookings.id);
                        });
                  },
                  height: 20,
                  textSize: 12,
                  boarderRadious: 6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget pickupCode(BuildContext context, WidgetRef ref) {
    void onChanged(String value, int index) {
      if (value.length == 1 && index < 3) {
        focusNodes[index + 1].requestFocus();
      } else if (value.isEmpty && index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          AppLocalizations.of(context)!.enter_pickup_code,
          size: 16,
          isBold: true,
        ),
        const SizedBox(height: 4),
        CommonText(
          AppLocalizations.of(
            context,
          )!.asked_the_passanger_for_the_code_to_confirm_their_pickup,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: CommonOtpField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        onChanged: (value) => onChanged(value, index),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(width: 10),
            CommonButton(
              AppLocalizations.of(context)!.verify,
              width: 90,
              height: 30,
              boarderRadious: 8,
              onTap: () async {
                final otp = controllers.map((e) => e.text).join();

                if (otp.length != 4) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter 4 digit code")),
                  );
                  return;
                }

                FocusScope.of(context).unfocus();

                final notifier = ref.read(
                  tripsBookingControllerProvider.notifier,
                );

                await notifier.verifyOtpToStartRide(
                  bookingId: widget.bookings.id,
                  otp: otp,
                );
                ref
                    .read(tripsPublishControllerProvider.notifier)
                    .publishedTripDetailsById(id: widget.tripId);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget finalCode() {
    void onChanged(String value, int index) {
      if (value.length == 1 && index < 3) {
        focusNodes[index + 1].requestFocus();
      } else if (value.isEmpty && index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        CommonText("Enter Final Code", size: 16, isBold: true),
        CommonText("Asked the Passanger for the code to confirm their pickup"),
        SizedBox(),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return CommonOtpField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      onChanged: (value) => onChanged(value, index),
                    );
                  }),
                ),
              ),
            ),
            CommonButton(
              "Verify",
              width: 90,
              height: 30,
              boarderRadious: 8,
              onTap: () async {
                final otp = controllers.map((e) => e.text).join();

                if (otp.length != 4) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter 4 digit code")),
                  );
                  return;
                }

                FocusScope.of(context).unfocus();

                final notifier = ref.read(
                  tripsBookingControllerProvider.notifier,
                );
                await notifier.verifyOtpToEndRide(
                  bookingId: widget.bookings.id,
                  otp: otp,
                );
                ref
                    .read(tripsPublishControllerProvider.notifier)
                    .publishedTripDetailsById(id: widget.tripId);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget compleate(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: CommonButton(
        AppLocalizations.of(context)!.trip_compleated,
        color: AppColors.textSecondary,
        textSize: 12,
        boarderRadious: 5,
        onTap: null,
        iconWidget: Icon(
          Icons.check_circle_outline_outlined,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget onTheWay(WidgetRef ref) {
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          AppLocalizations.of(context)!.trip_in_progress,
          size: 16,
          isBold: true,
        ),
        SizedBox(
          height: 36.h,
          child: CommonButton(
            AppLocalizations.of(context)!.arived_at_destination,

            textSize: 12,
            boarderRadious: 5,
            onTap: () {
              ref
                  .read(tripsPublishControllerProvider.notifier)
                  .genarateOtp(id: widget.bookings.id);
            },
            iconWidget: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Iconsax.send_2_outline, color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }
}
