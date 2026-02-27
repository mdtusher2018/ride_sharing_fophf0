import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/models/location_model.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';
import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class PassengerBookedTripResponse {
  final bool success;
  final String message;
  final BookedTripData data;

  PassengerBookedTripResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PassengerBookedTripResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PassengerBookedTripResponse.empty();
    return PassengerBookedTripResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: BookedTripData.fromJson(json['data']),
    );
  }

  factory PassengerBookedTripResponse.empty() => PassengerBookedTripResponse(
    success: false,
    message: '',
    data: BookedTripData.empty(),
  );

  List<PassengerBookingModel> get bookings => data.bookings;
}

class BookedTripData {
  final List<PassengerBookingModel> bookings;
  final PaginationMetaModel pagination;

  BookedTripData({required this.bookings, required this.pagination});

  factory BookedTripData.fromJson(Map<String, dynamic>? json) {
    return BookedTripData(
      bookings: JsonHelper.safeList(
        json?['bookings'],
        (e) => PassengerBookingModel.fromJson(e),
      ),
      pagination: PaginationMetaModel.fromJson(json?['pagination']),
    );
  }

  factory BookedTripData.empty() =>
      BookedTripData(bookings: [], pagination: PaginationMetaModel.empty());
}

class PassengerBookingModel {
  final PassengerDetails? packageDetails;
  final List<PackageDetails> packages;
  final LocationWithAddressModel pickupLocation;
  final LocationWithAddressModel dropoffLocation;
  final String id;
  final Trip trip;
  final String passengerId;
  final Driver driver;
  final String bookingType;
  final String? passengerImage;
  final int? seatsBooked;
  final double totalPrice;
  final BookingStatus status;
  final String paymentStatus;
  final bool otpVerified;
  final bool dropoffOtpVerified;
  final DateTime bookingDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String pickupOTP;

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
    required this.pickupOTP,
  });

  factory PassengerBookingModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PassengerBookingModel.empty();

    return PassengerBookingModel(
      packageDetails: json['packageDetails'] != null
          ? PassengerDetails.fromJson(json['packageDetails'])
          : null,
      packages: JsonHelper.safeList(
        json['packages'],
        (e) => PackageDetails.fromJson(e),
      ),
      pickupLocation: LocationWithAddressModel.fromJson(json['pickupLocation']),
      dropoffLocation: LocationWithAddressModel.fromJson(
        json['dropoffLocation'],
      ),
      id: JsonHelper.stringVal(json['_id']),
      trip: Trip.fromJson(json['trip']),
      passengerId: JsonHelper.stringVal(json['passenger']),
      driver: Driver.fromJson(json['driver']),
      bookingType: JsonHelper.stringVal(json['bookingType']),
      passengerImage: JsonHelper.stringVal(json['passengerImage']),
      seatsBooked: JsonHelper.intVal(json['seatsBooked']),
      totalPrice: JsonHelper.doubleVal(json['totalPrice']),
      status: (json['status'] as String?).toBookingStatus(),
      paymentStatus: JsonHelper.stringVal(json['paymentStatus']),
      otpVerified: JsonHelper.boolVal(json['otpVerified']),
      dropoffOtpVerified: JsonHelper.boolVal(json['dropoffOtpVerified']),
      bookingDate: JsonHelper.parseDate(json['bookingDate']),
      createdAt: JsonHelper.parseDate(json['createdAt']),
      updatedAt: JsonHelper.parseDate(json['updatedAt']),
      pickupOTP: JsonHelper.stringVal(json['pickupOTP'], fallback: "Pending"),
    );
  }

  factory PassengerBookingModel.empty() => PassengerBookingModel(
    packageDetails: null,
    packages: [],
    pickupLocation: LocationWithAddressModel.empty(),
    dropoffLocation: LocationWithAddressModel.empty(),
    id: '',
    trip: Trip.empty(),
    passengerId: '',
    driver: Driver.empty(),
    bookingType: '',
    passengerImage: null,
    seatsBooked: null,
    totalPrice: 0.0,
    status: BookingStatus.unknown,
    paymentStatus: '',
    otpVerified: false,
    dropoffOtpVerified: false,
    bookingDate: DateTime.fromMillisecondsSinceEpoch(0),
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
    pickupOTP: "Pending",
  );
}

// Passenger Details for travel
class PassengerDetails {
  final int quantity;

  PassengerDetails({required this.quantity});

  factory PassengerDetails.fromJson(Map<String, dynamic>? json) {
    return PassengerDetails(quantity: JsonHelper.intVal(json?['quantity']));
  }

  factory PassengerDetails.empty() => PassengerDetails(quantity: 0);
}

// Trip
class Trip {
  final LocationWithAddressModel pickupLocation;
  final LocationWithAddressModel dropoffLocation;
  final String id;
  final Vehicle vehicle;
  final double distance;
  final int estimatedDuration;
  final DateTime departureTime;
  final double pricePerSeat;
  final String status;

  Trip({
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

  factory Trip.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Trip.empty();
    return Trip(
      pickupLocation: LocationWithAddressModel.fromJson(json['pickupLocation']),
      dropoffLocation: LocationWithAddressModel.fromJson(
        json['dropoffLocation'],
      ),
      id: JsonHelper.stringVal(json['_id']),
      vehicle: Vehicle.fromJson(json['vehicle']),
      distance: JsonHelper.doubleVal(json['distance']),
      estimatedDuration: JsonHelper.intVal(json['estimatedDuration']),
      departureTime: JsonHelper.parseDate(json['departureTime']),
      pricePerSeat: JsonHelper.doubleVal(json['pricePerSeat']),
      status: JsonHelper.stringVal(json['status']),
    );
  }

  factory Trip.empty() => Trip(
    pickupLocation: LocationWithAddressModel.empty(),
    dropoffLocation: LocationWithAddressModel.empty(),
    id: '',
    vehicle: Vehicle.empty(),
    distance: 0.0,
    estimatedDuration: 0,
    departureTime: DateTime.fromMillisecondsSinceEpoch(0),
    pricePerSeat: 0.0,
    status: '',
  );
}

// Vehicle
class Vehicle {
  final String id;
  final int year;
  final String vehicleModel;
  final List<String> vehicleImages;

  Vehicle({
    required this.id,
    required this.year,
    required this.vehicleModel,
    required this.vehicleImages,
  });

  factory Vehicle.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Vehicle.empty();
    return Vehicle(
      id: JsonHelper.stringVal(json['_id']),
      year: JsonHelper.intVal(json['year']),
      vehicleModel: JsonHelper.stringVal(json['vehicleModel']),
      vehicleImages:
          (json['vehicleImages'] as List?)?.map((e) => e.toString()).toList() ??
          [],
    );
  }

  factory Vehicle.empty() =>
      Vehicle(id: '', year: 0, vehicleModel: '', vehicleImages: []);
}

// Driver
class Driver {
  final String id;
  final String fullName;
  final String email;
  final String? image;
  final String? phone;
  final double rating;

  Driver({
    required this.id,
    required this.fullName,
    required this.email,
    this.image,
    this.phone,
    required this.rating,
  });

  factory Driver.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Driver.empty();
    return Driver(
      id: JsonHelper.stringVal(json['_id']),
      fullName: JsonHelper.stringVal(json['fullName']),
      email: JsonHelper.stringVal(json['email']),
      image: JsonHelper.stringVal(json['image']),
      phone: JsonHelper.stringVal(json['phone']),
      rating: JsonHelper.doubleVal(json['ratting']),
    );
  }

  factory Driver.empty() => Driver(
    id: '',
    fullName: '',
    email: '',
    image: null,
    phone: null,
    rating: 0.0,
  );
}

// Package Details
class PackageDetails {
  final String id;
  final PackageDimensions dimensions;
  final double weight;
  final int quantity;
  final String description;

  PackageDetails({
    required this.id,
    required this.dimensions,
    required this.weight,
    required this.quantity,
    required this.description,
  });

  factory PackageDetails.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PackageDetails.empty();
    return PackageDetails(
      id: JsonHelper.stringVal(json['_id']),
      dimensions: PackageDimensions.fromJson(json['dimensions']),
      weight: JsonHelper.doubleVal(json['weight']),
      quantity: JsonHelper.intVal(json['quantity']),
      description: JsonHelper.stringVal(json['description']),
    );
  }

  factory PackageDetails.empty() => PackageDetails(
    id: '',
    dimensions: PackageDimensions.empty(),
    weight: 0.0,
    quantity: 0,
    description: '',
  );
}

// Package Dimensions
class PackageDimensions {
  final double length;
  final double width;
  final double height;

  PackageDimensions({
    required this.length,
    required this.width,
    required this.height,
  });

  factory PackageDimensions.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PackageDimensions.empty();
    return PackageDimensions(
      length: JsonHelper.doubleVal(json['length']),
      width: JsonHelper.doubleVal(json['width']),
      height: JsonHelper.doubleVal(json['height']),
    );
  }

  factory PackageDimensions.empty() =>
      PackageDimensions(length: 0.0, width: 0.0, height: 0.0);

  double get volume => length * width * height;
}
