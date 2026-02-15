import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/models/location_model.dart';

class PassengerBookedDetailsResponse {
  final bool success;
  final String message;
  final _BookingDetailsData data;

  PassengerBookedDetailsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PassengerBookedDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PassengerBookedDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: _BookingDetailsData.fromJson(json['data'] ?? {}),
    );
  }

  PassengerBookingDetailsModel get booking => data.booking;
}

class _BookingDetailsData {
  final PassengerBookingDetailsModel booking;

  _BookingDetailsData({required this.booking});

  factory _BookingDetailsData.fromJson(Map<String, dynamic> json) {
    return _BookingDetailsData(
      booking: PassengerBookingDetailsModel.fromJson(json['booking'] ?? {}),
    );
  }
}

class PassengerBookingDetailsModel {
  final String id;
  final String bookingType;

  final LocationWithAddressModel pickupLocation;
  final LocationWithAddressModel dropoffLocation;

  final _TripModel trip;
  final _PassengerModel passenger;
  final _DriverModel driver;

  final int? seatsBooked;
  final List<_PackageDetails> packages;

  final double totalPrice;
  final BookingStatus status;
  final String paymentStatus;
  final String? paymentMethod;

  final bool otpVerified;
  final bool dropoffOtpVerified;

  final int? pickupOTP;
  final int? dropoffOTP;

  final DateTime bookingDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  PassengerBookingDetailsModel({
    required this.id,
    required this.bookingType,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.trip,
    required this.passenger,
    required this.driver,
    this.seatsBooked,
    required this.packages,
    required this.totalPrice,
    required this.status,
    required this.paymentStatus,
    this.paymentMethod,
    required this.otpVerified,
    required this.dropoffOtpVerified,
    this.pickupOTP,
    this.dropoffOTP,
    required this.bookingDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PassengerBookingDetailsModel.fromJson(Map<String, dynamic> json) {
    return PassengerBookingDetailsModel(
      id: json['_id'] ?? '',
      bookingType: json['bookingType'] ?? '',

      pickupLocation: LocationWithAddressModel.fromJson(
        json['pickupLocation'] ?? {},
      ),

      dropoffLocation: LocationWithAddressModel.fromJson(
        json['dropoffLocation'] ?? {},
      ),

      trip: _TripModel.fromJson(json['trip'] ?? {}),

      passenger: _PassengerModel.fromJson(json['passenger'] ?? {}),

      driver: _DriverModel.fromJson(json['driver'] ?? {}),

      seatsBooked: json['seatsBooked'],

      packages:
          (json['packages'] as List<dynamic>?)
              ?.map((e) => _PackageDetails.fromJson(e))
              .toList() ??
          [],

      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,

      status: (json['status'] as String?).toBookingStatus(),

      paymentStatus: json['paymentStatus'] ?? '',
      paymentMethod: json['paymentMethod'],

      otpVerified: json['otpVerified'] ?? false,
      dropoffOtpVerified: json['dropoffOtpVerified'] ?? false,

      pickupOTP: json['pickupOTP'],
      dropoffOTP: json['dropoffOTP'],

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

class _PassengerModel {
  final String id;
  final String fullName;
  final String email;
  final String? phone;

  _PassengerModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
  });

  factory _PassengerModel.fromJson(Map<String, dynamic> json) {
    return _PassengerModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
    );
  }
}

class _DriverModel {
  final String id;
  final String fullName;
  final String email;
  final String? image;
  final String? phone;

  _DriverModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.image,
    this.phone,
  });

  factory _DriverModel.fromJson(Map<String, dynamic> json) {
    return _DriverModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      image: json['image'],
      phone: json['phone'],
    );
  }
}

class _TripModel {
  final String id;
  final LocationWithAddressModel pickupLocation;
  final LocationWithAddressModel dropoffLocation;
  final _VehicleModel vehicle;
  final double distance;
  final int estimatedDuration;
  final DateTime departureTime;
  final double pricePerSeat;
  final String status;

  _TripModel({
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.vehicle,
    required this.distance,
    required this.estimatedDuration,
    required this.departureTime,
    required this.pricePerSeat,
    required this.status,
  });

  factory _TripModel.fromJson(Map<String, dynamic> json) {
    return _TripModel(
      id: json['_id'] ?? '',
      pickupLocation: LocationWithAddressModel.fromJson(
        json['pickupLocation'] ?? {},
      ),
      dropoffLocation: LocationWithAddressModel.fromJson(
        json['dropoffLocation'] ?? {},
      ),
      vehicle: _VehicleModel.fromJson(json['vehicle'] ?? {}),
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      estimatedDuration: json['estimatedDuration'] ?? 0,
      departureTime:
          DateTime.tryParse(json['departureTime'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      pricePerSeat: (json['pricePerSeat'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? '',
    );
  }
}

class _VehicleModel {
  final String id;
  final int year;
  final String vehicleModel;
  final List<String> vehicleImages;

  _VehicleModel({
    required this.id,
    required this.year,
    required this.vehicleModel,
    required this.vehicleImages,
  });

  factory _VehicleModel.fromJson(Map<String, dynamic> json) {
    return _VehicleModel(
      id: json['_id'] ?? '',
      year: json['year'] ?? 0,
      vehicleModel: json['vehicleModel'] ?? '',
      vehicleImages:
          (json['vehicleImages'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
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
}
