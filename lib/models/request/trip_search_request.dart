import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';

// class TripSearchRequest {
//   final BookingType bookingType;
//   final LatLng? pickupLatLng;
//   final String pickupAddress;
//   final LatLng? destinationLatLng;
//   final String destinationAddress;
//   final DateTime departureTime;
//   /// for travel
//   final int passengersCount;
//   /// for package
//   final List<PackageItem> packages;
//   TripSearchRequest({
//     required this.bookingType,
//     required this.pickupLatLng,
//     required this.pickupAddress,
//     required this.destinationLatLng,
//     required this.destinationAddress,
//     required this.departureTime,
//     required this.passengersCount,
//     required this.packages,
//   });
// }

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

class TripSearchRequest {
  final BookingType bookingType;

  final LatLng? pickupLatLng;
  final String pickupAddress;

  final LatLng? destinationLatLng;
  final String destinationAddress;

  final DateTime departureTime;

  /// for travel
  final int passengersCount;
  final String? vehicaleType;
  final String? badge;
  final String? ratting;
  final bool? verifiedProfile;
  final bool? autoReservation;

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
    this.autoReservation,
    this.badge,
    this.ratting,
    this.vehicaleType,
    this.verifiedProfile,
  });

  TripSearchRequest copyWith({
    BookingType? bookingType,
    LatLng? pickupLatLng,
    String? pickupAddress,
    LatLng? destinationLatLng,
    String? destinationAddress,
    DateTime? departureTime,
    int? passengersCount,
    String? vehicaleType,
    String? level,
    String? ratting,
    bool? verifiedProfile,
    bool? autoReservation,
    List<PackageItem>? packages,
  }) {
    return TripSearchRequest(
      bookingType: bookingType ?? this.bookingType,
      pickupLatLng: pickupLatLng ?? this.pickupLatLng,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      destinationAddress: destinationAddress ?? this.destinationAddress,
      departureTime: departureTime ?? this.departureTime,
      passengersCount: passengersCount ?? this.passengersCount,
      vehicaleType: vehicaleType ?? this.vehicaleType,
      badge: level ?? this.badge,
      ratting: ratting ?? this.ratting,
      verifiedProfile: verifiedProfile ?? this.verifiedProfile,
      autoReservation: autoReservation ?? this.autoReservation,
      packages: packages ?? this.packages,
    );
  }
}
