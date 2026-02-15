import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/models/location_model.dart';

class PublishedTripDetailsResponse {
  final bool success;
  final String message;
  final _PublishedTripData data;

  PublishedTripDetailsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PublishedTripDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PublishedTripDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: _PublishedTripData.fromJson(json['data'] ?? {}),
    );
  }
}

class _PublishedTripData {
  final List<PublishedTripDetail> bookings;

  _PublishedTripData({required this.bookings});

  factory _PublishedTripData.fromJson(Map<String, dynamic> json) {
    return _PublishedTripData(
      bookings:
          (json['bookings'] as List<dynamic>?)
              ?.map((e) => PublishedTripDetail.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class PublishedTripDetail {
  final String id;
  final String trip;
  final String driver;
  final String bookingType;
  final String passengerImage;
  final int seatsBooked;
  final num totalPrice;
  final BookingStatus status;
  final String paymentStatus;
  final bool otpVerified;
  final bool dropoffOtpVerified;
  final DateTime bookingDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  final LocationWithAddressModel pickupLocation;
  final LocationWithAddressModel dropoffLocation;
  final TripPassenger passenger;
  final TripPackageDetails packageDetails;
  final List<dynamic> packages;

  PublishedTripDetail({
    required this.id,
    required this.trip,
    required this.driver,
    required this.bookingType,
    required this.passengerImage,
    required this.seatsBooked,
    required this.totalPrice,
    required this.status,
    required this.paymentStatus,
    required this.otpVerified,
    required this.dropoffOtpVerified,
    required this.bookingDate,
    required this.createdAt,
    required this.updatedAt,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.passenger,
    required this.packageDetails,
    required this.packages,
  });

  factory PublishedTripDetail.fromJson(Map<String, dynamic> json) {
    return PublishedTripDetail(
      id: json['_id'] ?? '',
      trip: json['trip'] ?? '',
      driver: json['driver'] ?? '',
      bookingType: json['bookingType'] ?? '',
      passengerImage: json['passengerImage'] ?? '',
      seatsBooked: json['seatsBooked'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
      status: ((json['status'] ?? "").toString()).toBookingStatus(),
      paymentStatus: json['paymentStatus'] ?? '',
      otpVerified: json['otpVerified'] ?? false,
      dropoffOtpVerified: json['dropoffOtpVerified'] ?? false,
      bookingDate:
          DateTime.tryParse(json['bookingDate'] ?? '') ?? DateTime.now(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      pickupLocation: LocationWithAddressModel.fromJson(
        json['pickupLocation'] ?? {},
      ),
      dropoffLocation: LocationWithAddressModel.fromJson(
        json['dropoffLocation'] ?? {},
      ),
      passenger: TripPassenger.fromJson(json['passenger'] ?? {}),
      packageDetails: TripPackageDetails.fromJson(json['packageDetails'] ?? {}),
      packages: json['packages'] ?? [],
    );
  }
}

class TripPassenger {
  final String id;
  final String fullName;
  final String email;

  TripPassenger({
    required this.id,
    required this.fullName,
    required this.email,
  });

  factory TripPassenger.fromJson(Map<String, dynamic> json) {
    return TripPassenger(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class TripPackageDetails {
  final int quantity;

  TripPackageDetails({required this.quantity});

  factory TripPackageDetails.fromJson(Map<String, dynamic> json) {
    return TripPackageDetails(quantity: json['quantity'] ?? 0);
  }
}
