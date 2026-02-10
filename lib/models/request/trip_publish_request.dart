import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripPublishRequest {
  // pickup
  String? pickupAddress;
  LatLng? pickupLatLng;

  // dropoff
  String? dropoffAddress;
  LatLng? dropoffLatLng;

  // route
  String? routePolyLine;

  // vehicle & seats
  String? vehicleId;
  int? totalSeats;
  String? notes;

  // pricing & time
  double? pricePerSeat;
  DateTime? departureTime;

  // image
  File? driverImage;

  bool get isReadyToPublish =>
      pickupAddress != null &&
      pickupLatLng != null &&
      dropoffAddress != null &&
      dropoffLatLng != null &&
      routePolyLine != null &&
      vehicleId != null &&
      totalSeats != null &&
      pricePerSeat != null &&
      departureTime != null &&
      driverImage != null;
}
