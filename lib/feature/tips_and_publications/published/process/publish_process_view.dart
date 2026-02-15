import 'dart:developer';

import 'package:flutter/material.dart' hide Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/services/providers.dart';
import 'package:velozaje/core/utils/defult_values.dart';
import 'package:velozaje/core/utils/extention.dart';
import 'package:velozaje/core/utils/map_helper.dart';
import 'package:velozaje/feature/take_image_view.dart';
import 'package:velozaje/feature/widget/date_time_picker.dart';
import 'package:velozaje/feature/widget/vehicale_card.dart';
import 'package:velozaje/models/request/trip_publish_request.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/res/common_text_field_with_title.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/res/location_search_textfield.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

part 'publishFormView.dart';
part 'routeSelectionView.dart';
part 'vehicleSpaceView.dart';
part 'setPriceView.dart';

enum PublishStep { locationPick, routeSelection, vehicleSpace, setPrice }

class PublishProcessPage extends StatefulWidget {
  const PublishProcessPage({super.key});

  @override
  State<PublishProcessPage> createState() => _PublishProcessPageState();
}

class _PublishProcessPageState extends State<PublishProcessPage> {
  // Pickup and Destination (Controller, LatLng)
  (TextEditingController, LatLng?) pickup = (TextEditingController(), null);
  (TextEditingController, LatLng?) destination = (
    TextEditingController(),
    null,
  );

  GoogleMapController? _mapController;
  PublishStep currentStep = PublishStep.locationPick;

  Set<Polyline> _polylines = {};
  List<Route> _routes = const [];

  // Trip data
  TripPublishRequest publishTripData = TripPublishRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGoogleMap(),
          _buildBackButton(),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomView()),
        ],
      ),
    );
  }

  // -------------------------
  // Google Map Widget
  // -------------------------
  Widget _buildGoogleMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: AppDefaultValue.latLng,
        zoom: 10,
      ),
      polylines: _polylines,
      onMapCreated: (controller) => _mapController = controller,
      markers: _buildMarkers(),
    );
  }

  Set<Marker> _buildMarkers() {
    final markers = <Marker>{};
    if (pickup.$2 != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: pickup.$2!,
          infoWindow: const InfoWindow(title: 'Pickup Location'),
        ),
      );
    }
    if (destination.$2 != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('dropoff'),
          position: destination.$2!,
          infoWindow: const InfoWindow(title: 'Dropoff Location'),
        ),
      );
    }
    return markers;
  }

  // -------------------------
  // Back Button
  // -------------------------
  Widget _buildBackButton() {
    return Positioned(
      top: 40.h,
      left: 16.w,
      child: InkWell(
        onTap: () {
          if (Navigator.canPop(context)) Navigator.pop(context);
        },
        child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.arrow_back_ios_sharp, color: AppColors.white),
        ),
      ),
    );
  }

  // -------------------------
  // Bottom Step View
  // -------------------------
  Widget _buildBottomView() {
    switch (currentStep) {
      case PublishStep.locationPick:
        return PublishFormView(
          pickup: pickup,
          destination: destination,
          onContinue: (DateTime? dateTime) {
            if (_validateCurrentStep(dateTime: dateTime)) {
              setState(() => currentStep = PublishStep.routeSelection);
            }
          },
          onPickupSelected: _onPickupSelected,
          onDestinationSelected: _onDestinationSelected,
        );

      case PublishStep.routeSelection:
        return RouteSelectionView(
          routes: _routes,
          onContinue: (routeEncoded) {
            if (_validateCurrentStep(routeString: routeEncoded)) {
              setState(() => currentStep = PublishStep.vehicleSpace);
            }
          },
          onRouteSelected: _onRouteSelected,
        );

      case PublishStep.vehicleSpace:
        return VehicleSpaceView(
          onContinue: (vehicaleId, seats) {
            publishTripData
              ..vehicleId = vehicaleId
              ..totalSeats = seats;
            if (_validateCurrentStep()) {
              setState(() => currentStep = PublishStep.setPrice);
            }
          },
        );

      case PublishStep.setPrice:
        return SetPriceView(
          onContinue: (pricePerSeat, note) {
            publishTripData
              ..pricePerSeat = pricePerSeat
              ..notes = note;
            if (_validateCurrentStep()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TakePhotoPage(
                    forPublish: true,
                    publishTripData: publishTripData,
                  ),
                ),
              );
            }
          },
        );
    }
  }

  // -------------------------
  // Map interaction
  // -------------------------
  void _onPickupSelected(String address, LatLng latLng) {
    if (_mapController == null) return;
    setState(() {
      pickup.$1.text = address;
      pickup = (pickup.$1, latLng);
    });

    MapHelper.moveCamera(latLng, _mapController!);
    _drawRoutesIfReady();
  }

  void _onDestinationSelected(String address, LatLng latLng) {
    if (_mapController == null) return;
    setState(() {
      destination.$1.text = address;
      destination = (destination.$1, latLng);
    });
    MapHelper.moveCamera(latLng, _mapController!);
    _drawRoutesIfReady();
  }

  Future<void> _drawRoutesIfReady() async {
    if (_mapController == null || pickup.$2 == null || destination.$2 == null) {
      return;
    }

    final result = await MapHelper.drawRoutes(
      origin: pickup.$2!,
      color: AppColors.primary,
      destination: destination.$2!,
    );

    if (result.polylines.isEmpty || result.routes.isEmpty) return;

    setState(() {
      _polylines = result.polylines;
      _routes = result.routes;
    });

    MapHelper.fitBounds(result.polylines.first.points, _mapController!);
  }

  void _onRouteSelected(int selectedIndex) {
    if (selectedIndex == -1) {
      context.showErrorSnackbar(
        title: "Validation Error",
        message: "Select a path",
      );
    }
    final updatedPolylines = <Polyline>{};
    int i = 0;

    for (final poly in _polylines) {
      updatedPolylines.add(
        poly.copyWith(
          colorParam: i == selectedIndex ? Colors.blue : AppColors.primary,
          widthParam: i == selectedIndex ? 7 : 4,
          zIndexParam: i == selectedIndex ? 2 : 1,
        ),
      );
      i++;
    }

    setState(() => _polylines = updatedPolylines);

    if (_mapController != null) {
      MapHelper.fitBounds(
        updatedPolylines.elementAt(selectedIndex).points,
        _mapController!,
      );
    }
  }

  // -------------------------
  // Validation for each step
  // -------------------------
  bool _validateCurrentStep({DateTime? dateTime, String? routeString}) {
    switch (currentStep) {
      case PublishStep.locationPick:
        if (pickup.$2 == null) {
          return _showError('Please select a pickup location.');
        }
        if (destination.$2 == null) {
          return _showError('Please select a dropoff location.');
        }
        if (dateTime == null) {
          return _showError('Please select a departure time.');
        }

        // Save to publishTripData
        publishTripData
          ..pickupAddress = pickup.$1.text
          ..pickupLatLng = pickup.$2
          ..dropoffAddress = destination.$1.text
          ..dropoffLatLng = destination.$2
          ..departureTime = dateTime;
        return true;

      case PublishStep.routeSelection:
        if (_routes.isEmpty || !_polylines.any((p) => p.color == Colors.blue)) {
          return _showError('Please select a route.');
        }

        publishTripData.routePolyLine = routeString;

        return true;

      case PublishStep.vehicleSpace:
        if (publishTripData.vehicleId == null) {
          return _showError(
            'Failed to retrieve your vehicle. Please add a vehicle first.',
          );
        }

        if (publishTripData.totalSeats == null ||
            publishTripData.totalSeats! <= 0) {
          return _showError('Please enter a valid number of seats.');
        }

        return true;

      case PublishStep.setPrice:
        if (publishTripData.pricePerSeat == null ||
            publishTripData.pricePerSeat! <= 0) {
          return _showError('Please set a price per seat.');
        }
        if (publishTripData.notes == null || publishTripData.notes!.isEmpty) {
          return _showError('Please leave a notes for passengers.');
        }
        return true;
    }
  }

  bool _showError(String message) {
    context.showErrorSnackbar(title: "Error", message: message);
    return false;
  }
}
