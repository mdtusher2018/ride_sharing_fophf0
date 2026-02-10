import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';

class TripSearchRequest {
  final BookingType bookingType;

  final LatLng? pickupLatLng;
  final String pickupAddress;

  final LatLng? destinationLatLng;
  final String destinationAddress;

  final DateTime departureTime;

  /// for travel
  final int passengersCount;

  /// for package
  final List<PackageItem> packages;

  TripSearchRequest({
    required this.bookingType,
    required this.pickupLatLng,
    required this.pickupAddress,
    required this.destinationLatLng,
    required this.destinationAddress,
    required this.departureTime,
    required this.passengersCount,
    required this.packages,
  });
}

class PackageItem {
  final double weightKg;
  final double lengthCm;
  final double widthCm;
  final double heightCm;

  PackageItem({
    required this.weightKg,
    required this.lengthCm,
    required this.widthCm,
    required this.heightCm,
  });
}
