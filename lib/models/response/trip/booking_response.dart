import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/models/location_model.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';

class PassengerBookedTripResponse {
  final bool success;
  final String message;
  final _BookedTripData data;

  PassengerBookedTripResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PassengerBookedTripResponse.fromJson(Map<String, dynamic> json) {
    return PassengerBookedTripResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: _BookedTripData.fromJson(json['data'] ?? {}),
    );
  }

  List<PassengerBookingModel> get bookings => data.bookings;
}

class _BookedTripData {
  final List<PassengerBookingModel> bookings;
  final PaginationMetaModel pagination;

  _BookedTripData({required this.bookings, required this.pagination});

  factory _BookedTripData.fromJson(Map<String, dynamic> json) {
    return _BookedTripData(
      bookings: (json['bookings'] as List<dynamic>? ?? [])
          .map((e) => PassengerBookingModel.fromJson(e))
          .toList(),
      pagination: PaginationMetaModel.fromJson(json['pagination'] ?? {}),
    );
  }
}

class PassengerBookingModel {
  final _PassengerDetails? packageDetails; // for travel
  final List<_PackageDetails> packages; // for package

  final LocationWithAddressModel pickupLocation;
  final LocationWithAddressModel dropoffLocation;
  final String id;
  final _Trip trip;
  final String passengerId;
  final _Driver driver;
  final String bookingType;

  final String? passengerImage; // nullable
  final int? seatsBooked; // nullable (only travel)

  final double totalPrice;
  final BookingStatus status;
  final String paymentStatus;
  final bool otpVerified;
  final bool dropoffOtpVerified;
  final DateTime bookingDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  PassengerBookingModel({
    this.packageDetails,
    required this.packages,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.id,
    required this.trip,
    required this.passengerId,
    required this.driver,
    required this.bookingType,
    this.passengerImage,
    this.seatsBooked,
    required this.totalPrice,
    required this.status,
    required this.paymentStatus,
    required this.otpVerified,
    required this.dropoffOtpVerified,
    required this.bookingDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PassengerBookingModel.fromJson(Map<String, dynamic> json) {
    return PassengerBookingModel(
      packageDetails: json['packageDetails'] != null
          ? _PassengerDetails.fromJson(json['packageDetails'])
          : null,

      packages:
          (json['packages'] as List<dynamic>?)
              ?.map((e) => _PackageDetails.fromJson(e))
              .toList() ??
          [],

      pickupLocation: LocationWithAddressModel.fromJson(
        json['pickupLocation'] ?? {},
      ),

      dropoffLocation: LocationWithAddressModel.fromJson(
        json['dropoffLocation'] ?? {},
      ),

      id: json['_id'] ?? '',

      trip: _Trip.fromJson(json['trip'] ?? {}),

      passengerId: json['passenger'] ?? '',

      driver: _Driver.fromJson(json['driver'] ?? {}),

      bookingType: json['bookingType'] ?? '',

      passengerImage: json['passengerImage'],

      seatsBooked: json['seatsBooked'] is int
          ? json['seatsBooked']
          : int.tryParse(json['seatsBooked']?.toString() ?? ''),

      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,

      status: (json['status'] as String?).toBookingStatus(),

      paymentStatus: json['paymentStatus'] ?? '',

      otpVerified: json['otpVerified'] ?? false,

      dropoffOtpVerified: json['dropoffOtpVerified'] ?? false,

      bookingDate:
          DateTime.tryParse(json['bookingDate'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),

      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),

      updatedAt:
          DateTime.tryParse(json['updatedAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}

class _PassengerDetails {
  final int quantity;

  _PassengerDetails({required this.quantity});

  factory _PassengerDetails.fromJson(Map<String, dynamic> json) {
    return _PassengerDetails(quantity: json['quantity'] ?? 0);
  }
}

class _Trip {
  final LocationWithAddressModel pickupLocation;
  final LocationWithAddressModel dropoffLocation;
  final String id;
  final _Vehicle vehicle;
  final double distance;
  final int estimatedDuration;
  final DateTime departureTime;
  final double pricePerSeat;
  final String status;

  _Trip({
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.id,
    required this.vehicle,
    required this.distance,
    required this.estimatedDuration,
    required this.departureTime,
    required this.pricePerSeat,
    required this.status,
  });

  factory _Trip.fromJson(Map<String, dynamic> json) {
    return _Trip(
      pickupLocation: LocationWithAddressModel.fromJson(
        json['pickupLocation'] ?? {},
      ),
      dropoffLocation: LocationWithAddressModel.fromJson(
        json['dropoffLocation'] ?? {},
      ),
      id: json['_id'] ?? '',
      vehicle: _Vehicle.fromJson(json['vehicle'] ?? {}),
      distance: (json['distance'] is num)
          ? (json['distance'] as num).toDouble()
          : double.tryParse(json['distance'].toString()) ?? 0.0,
      estimatedDuration: json['estimatedDuration'] ?? 0,
      departureTime:
          DateTime.tryParse(json['departureTime'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      pricePerSeat: (json['pricePerSeat'] is num)
          ? (json['pricePerSeat'] as num).toDouble()
          : double.tryParse(json['pricePerSeat'].toString()) ?? 0.0,
      status: json['status'] ?? '',
    );
  }
}

class _Vehicle {
  final String id;
  final int year;
  final String vehicleModel;
  final List<String> vehicleImages;

  _Vehicle({
    required this.id,
    required this.year,
    required this.vehicleModel,
    required this.vehicleImages,
  });

  factory _Vehicle.fromJson(Map<String, dynamic> json) {
    return _Vehicle(
      id: json['_id'] ?? '',
      year: json['year'] ?? 0,
      vehicleModel: json['vehicleModel'] ?? '',
      vehicleImages: (json['vehicleImages'] is List)
          ? List<String>.from(json['vehicleImages'].map((e) => e.toString()))
          : [],
    );
  }
}

class _Driver {
  final String id;
  final String fullName;
  final String email;
  final String? image;
  final String? phone;
  final num? rating;

  _Driver({
    required this.id,
    required this.fullName,
    required this.email,
    this.image,
    this.phone,
    this.rating,
  });

  factory _Driver.fromJson(Map<String, dynamic> json) {
    return _Driver(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      image: json['image'],
      phone: json['phone'],
      rating: json['ratting'],
    );
  }
}

class _PackageDetails {
  final String id;
  final _PackageDimensions dimensions;
  final double weight;
  final int quantity;
  final String description;

  _PackageDetails({
    required this.id,
    required this.dimensions,
    required this.weight,
    required this.quantity,
    required this.description,
  });

  factory _PackageDetails.fromJson(Map<String, dynamic> json) {
    return _PackageDetails(
      id: json['_id'] ?? '',
      dimensions: _PackageDimensions.fromJson(json['dimensions'] ?? {}),
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      description: json['description'] ?? '',
    );
  }
}

class _PackageDimensions {
  final double length;
  final double width;
  final double height;

  _PackageDimensions({
    required this.length,
    required this.width,
    required this.height,
  });

  factory _PackageDimensions.fromJson(Map<String, dynamic> json) {
    return _PackageDimensions(
      length: (json['length'] as num?)?.toDouble() ?? 0.0,
      width: (json['width'] as num?)?.toDouble() ?? 0.0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
    );
  }

  double get volume => length * width * height;
}
