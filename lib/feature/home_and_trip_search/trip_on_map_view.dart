// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/core/utils/helper.dart';
import 'package:velozaje/core/utils/map_helper.dart';
import 'package:velozaje/feature/take_image_view.dart';
import 'package:velozaje/feature/widget/back_button.dart';
import 'package:velozaje/feature/widget/map_widget.dart';
import 'package:velozaje/feature/widget/vehicale_card.dart';
import 'package:velozaje/models/request/trip_search_request.dart';
import 'package:velozaje/models/response/trip/passenger_trip_model.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class TripOnMapView extends StatefulWidget {
  final PassengerTripModel tripDetails;
  final TripSearchRequest? bookingTripSearched;
  const TripOnMapView({
    super.key,
    required this.tripDetails,
    required this.bookingTripSearched,
  });

  @override
  State<TripOnMapView> createState() => _TripOnMapViewState();
}

class _TripOnMapViewState extends State<TripOnMapView> {
  GoogleMapController? _mapController;
  Set<Polyline>? polylines;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _drawRoutesIfReady() async {
    if (_mapController == null) return;

    final encodedString = widget.tripDetails.routePolyline;
    // r'''anvwFhqobMwE{Co@Ui@DQZKD_B_A{B{AUz@y@bC_Qti@kCfIo@zBoIzWwAvEdPnKvAbArAx@fMhIJ\fCfBHR?\c@vAMN_@@wAeCi@o@_@Wk@Ia@Bm@Xi@f@o@dA}DhIwAjEa@fBk@rD_@rA}Uju@_Zh_Aa@bBUbBGxA@rANxA\vAf@nAx@hArBjBdCdBf@XNAvCnAvB~Al@Hx@Mh@Y^]Xc@VaAFgAEw@O{@]s@e@c@q@_@gCeAoEkA_Do@qC_@{@?u@Jy@X}@f@w@jA}@bC{HhU}FpR{A~D_GfOgDxJcBfGuC|KyB`JcEzOOF[bAm@rAm@`AaAfAuEvE}AhAkCxAqCbAoXdGgEvAcChAwCfBoA|@}BpBqAnAgBvBiBfCeb@np@qv@dkAYD{AhAsAb@i@H}ELa@O{BCoC@iBK}AY{A_@cEuA{EsBq@_@Q[GYB]jAiCz@a@~@EvCrAdHpCNLz@^VRR^Hf@CnAWpKBtBUf@[\qAA}@Q}@c@m@m@iDcFa@YQGsCbG]dA''';

    final decodedPoints = PolylinePoints.decodePolyline(encodedString);

    Set<Polyline> routePolyline;

    final result = await MapHelper.drawRoutes(
      origin: LatLng(
        widget.tripDetails.pickupLocation.coordinates.latitude,
        widget.tripDetails.pickupLocation.coordinates.longitude,
      ),
      color: AppColors.primary,
      destination: LatLng(
        widget.tripDetails.dropoffLocation.coordinates.latitude,
        widget.tripDetails.dropoffLocation.coordinates.longitude,
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: AlignmentGeometry.bottomCenter,
        children: [
          /// --------------------
          /// Map Placeholder
          /// --------------------
          ReusableMapWidget(
            context: context,
            destinationLocation: LatLng(
              widget.tripDetails.dropoffLocation.coordinates.latitude,
              widget.tripDetails.dropoffLocation.coordinates.longitude,
            ),
            pickupLocation: LatLng(
              widget.tripDetails.pickupLocation.coordinates.latitude,
              widget.tripDetails.pickupLocation.coordinates.longitude,
            ),
            onMapCreated: (controller) {
              _mapController = controller;

              _drawRoutesIfReady();
            },
            polylines: polylines,
          ),

          /// --------------------
          /// Bottom Sheet Content
          /// --------------------
          Container(
            padding: const EdgeInsets.all(16),

            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 16.h),
                if (widget.tripDetails.vehicle != null)
                  VehicleCard(
                    image: widget.tripDetails.vehicle!.vehicleImages.first,
                    brand: widget.tripDetails.vehicle!.brand,
                    vehicleModel: widget.tripDetails.vehicle!.vehicleModel,
                    year: widget.tripDetails.vehicle!.year.toString(),
                    licensePlateNumber:
                        widget.tripDetails.vehicle!.licensePlateNumber,
                  ),
                SizedBox(height: 16.h),
                if (widget.tripDetails.driver != null)
                  _DriverCard(
                    email: widget.tripDetails.driver!.email,
                    name: widget.tripDetails.driver!.fullName,
                    image: widget.tripDetails.driverImage,
                    rides: widget.tripDetails.driver!.ratting.toStringAsFixed(
                      1,
                    ),
                  ),
                SizedBox(height: 16.h),

                /// Confirm Button
                CommonButton(
                  AppLocalizations.of(context)!.confirm_booking,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TakePhotoPage(
                            bookingTripDetails: widget.tripDetails,
                            bookingTripSearched: widget.bookingTripSearched,
                            onConfirmBooking: () {
                              _showWaitingDialog(context);
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),

          Positioned(top: 50, left: 30, child: CommonBackButton()),
        ],
      ),
    );
  }
}

/// --------------------
/// Driver Card
/// --------------------
class _DriverCard extends StatelessWidget {
  final String image, name, rides, email;
  const _DriverCard({
    required this.image,
    required this.name,
    required this.rides,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),

      child: Row(
        children: [
          CommonImage(path: getFullImagePath(image), width: 40, height: 40),
          const SizedBox(width: 12),

          /// Driver Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(name, fontWeight: FontWeight.w600),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star_rate_rounded, color: Colors.amber),
                    CommonText(rides, size: 12, color: AppColors.textPrimary),
                  ],
                ),
              ],
            ),
          ),

          /// Message Icon
          Card(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(Icons.mail, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}

void _showWaitingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16.h),

              /// Title
              CommonText(
                AppLocalizations.of(context)!.wait_for_driver_approval,
                size: 18,
                isBold: true,
              ),

              SizedBox(height: 8.h),

              /// Subtitle / message
              CommonText(
                AppLocalizations.of(
                  context,
                )!.we_ve_sent_your_request_waiting_for_a_driver_to_accept,
                textAlign: TextAlign.center,
                size: 14,
              ),

              SizedBox(height: 10.h),
              SizedBox(
                height: 36,
                child: CommonButton(
                  "Ok",
                  height: 30,
                  width: 60,
                  textSize: 14,
                  boarderRadious: 8,
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
