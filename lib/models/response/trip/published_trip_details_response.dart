// bookings_of_published_trip_response.dart
import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/models/location_model.dart';

class BookingsOfPublishedTripResponse {
  final bool success;
  final String message;
  final _PublishedTripData data;

  BookingsOfPublishedTripResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BookingsOfPublishedTripResponse.fromJson(Map<String, dynamic> json) {
    return BookingsOfPublishedTripResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] is Map<String, dynamic>
          ? _PublishedTripData.fromJson(json['data'])
          : _PublishedTripData.empty(),
    );
  }
}

class _PublishedTripData {
  final List<BookingsOfPublishedTrip> bookings;

  _PublishedTripData({required this.bookings});

  factory _PublishedTripData.fromJson(Map<String, dynamic> json) {
    return _PublishedTripData(
      bookings: (json['bookings'] as List<dynamic>? ?? [])
          .map((e) => BookingsOfPublishedTrip.fromJson(e))
          .toList(),
    );
  }

  factory _PublishedTripData.empty() => _PublishedTripData(bookings: []);
}

class BookingsOfPublishedTrip {
  final String id;
  final String trip;
  final String driver;
  final BookingType bookingType;
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
  final List<_PackageDetails> packages;

  BookingsOfPublishedTrip({
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
    required this.packages,
  });

  factory BookingsOfPublishedTrip.fromJson(Map<String, dynamic> json) {
    return BookingsOfPublishedTrip(
      id: json['_id'] ?? '',
      trip: json['trip'] ?? '',
      driver: json['driver'] ?? '',
      bookingType: ((json['bookingType'] ?? '').toString()).toBookingType(),
      passengerImage: json['passengerImage'] ?? '',
      seatsBooked: json['seatsBooked'] ?? 0,
      totalPrice: json['totalPrice'] ?? 0,
      status: ((json['status'] ?? '').toString()).toBookingStatus(),
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
      packages: (json['packages'] as List<dynamic>? ?? [])
          .map((e) => _PackageDetails.fromJson(e))
          .toList(),
    );
  }
}

class TripPassenger {
  final String id;
  final String fullName;
  final String email;
  final String image;

  TripPassenger({
    required this.id,
    required this.fullName,
    required this.email,
    required this.image,
  });

  factory TripPassenger.fromJson(Map<String, dynamic> json) {
    return TripPassenger(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class _PackageDetails {
  final String id;
  final _PackageDimensions dimensions;
  final double weight;
  final int quantity;
  final String description;
  final String price;

  _PackageDetails({
    required this.id,
    required this.dimensions,
    required this.weight,
    required this.quantity,
    required this.description,
    required this.price,
  });

  factory _PackageDetails.fromJson(Map<String, dynamic> json) {
    return _PackageDetails(
      id: json['_id'] ?? '',
      dimensions: _PackageDimensions.fromJson(json['dimensions'] ?? {}),
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      description: json['description'] ?? '',
      price: json['price'] ?? '0',
    );
  }
}

class _PackageDimensions {
  final int length;
  final int width;
  final int height;

  _PackageDimensions({
    required this.length,
    required this.width,
    required this.height,
  });

  factory _PackageDimensions.fromJson(Map<String, dynamic> json) {
    return _PackageDimensions(
      length: (json['length'] as num?)?.toInt() ?? 0,
      width: (json['width'] as num?)?.toInt() ?? 0,
      height: (json['height'] as num?)?.toInt() ?? 0,
    );
  }

  int get volume => length * width * height;
}
