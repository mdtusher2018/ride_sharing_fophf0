import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/models/location_model.dart';
import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class PassengerBookedDetailsResponse {
  final bool success;
  final String message;
  final BookingDetailsData data;

  PassengerBookedDetailsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PassengerBookedDetailsResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PassengerBookedDetailsResponse.empty();

    return PassengerBookedDetailsResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: BookingDetailsData.fromJson(json['data']),
    );
  }

  factory PassengerBookedDetailsResponse.empty() =>
      PassengerBookedDetailsResponse(
        success: false,
        message: '',
        data: BookingDetailsData.empty(),
      );

  PassengerBookingDetailsModel get booking => data.booking;
}

class BookingDetailsData {
  final PassengerBookingDetailsModel booking;

  BookingDetailsData({required this.booking});

  factory BookingDetailsData.fromJson(Map<String, dynamic>? json) {
    return BookingDetailsData(
      booking: PassengerBookingDetailsModel.fromJson(json?['booking']),
    );
  }

  factory BookingDetailsData.empty() =>
      BookingDetailsData(booking: PassengerBookingDetailsModel.empty());
}

class PassengerBookingDetailsModel {
  final String id;
  final String bookingType;

  final LocationWithAddressModel pickupLocation;
  final LocationWithAddressModel dropoffLocation;

  final TripModel trip;
  final PassengerModel passenger;
  final DriverModel driver;

  final int? seatsBooked;
  final List<PackageDetails> packages;

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

  factory PassengerBookingDetailsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PassengerBookingDetailsModel.empty();

    return PassengerBookingDetailsModel(
      id: JsonHelper.stringVal(json['_id']),
      bookingType: JsonHelper.stringVal(json['bookingType']),

      pickupLocation: LocationWithAddressModel.fromJson(json['pickupLocation']),
      dropoffLocation: LocationWithAddressModel.fromJson(
        json['dropoffLocation'],
      ),

      trip: TripModel.fromJson(json['trip']),
      passenger: PassengerModel.fromJson(json['passenger']),
      driver: DriverModel.fromJson(json['driver']),

      seatsBooked: JsonHelper.intVal(json['seatsBooked']),
      packages: JsonHelper.safeList(
        json['packages'],
        (e) => PackageDetails.fromJson(e),
      ),

      totalPrice: JsonHelper.doubleVal(json['totalPrice']),
      status: (json['status'] as String?).toBookingStatus(),
      paymentStatus: JsonHelper.stringVal(json['paymentStatus']),
      paymentMethod: JsonHelper.stringVal(json['paymentMethod']),

      otpVerified: JsonHelper.boolVal(json['otpVerified']),
      dropoffOtpVerified: JsonHelper.boolVal(json['dropoffOtpVerified']),

      pickupOTP: JsonHelper.intVal(json['pickupOTP']),
      dropoffOTP: JsonHelper.intVal(json['dropoffOTP']),

      bookingDate: JsonHelper.parseDate(json['bookingDate']),
      createdAt: JsonHelper.parseDate(json['createdAt']),
      updatedAt: JsonHelper.parseDate(json['updatedAt']),
    );
  }

  factory PassengerBookingDetailsModel.empty() => PassengerBookingDetailsModel(
    id: '',
    bookingType: '',
    pickupLocation: LocationWithAddressModel.empty(),
    dropoffLocation: LocationWithAddressModel.empty(),
    trip: TripModel.empty(),
    passenger: PassengerModel.empty(),
    driver: DriverModel.empty(),
    seatsBooked: null,
    packages: [],
    totalPrice: 0.0,
    status: BookingStatus.unknown,
    paymentStatus: '',
    paymentMethod: null,
    otpVerified: false,
    dropoffOtpVerified: false,
    pickupOTP: null,
    dropoffOTP: null,
    bookingDate: DateTime.fromMillisecondsSinceEpoch(0),
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );
}

class PassengerModel {
  final String id;
  final String fullName;
  final String email;
  final String? phone;

  PassengerModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
  });

  factory PassengerModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PassengerModel.empty();
    return PassengerModel(
      id: JsonHelper.stringVal(json['_id']),
      fullName: JsonHelper.stringVal(json['fullName']),
      email: JsonHelper.stringVal(json['email']),
      phone: JsonHelper.stringVal(json['phone']),
    );
  }

  factory PassengerModel.empty() =>
      PassengerModel(id: '', fullName: '', email: '', phone: null);
}

class DriverModel {
  final String id;
  final String fullName;
  final double rating;
  final String email;
  final String? image;
  final String? phone;

  DriverModel({
    required this.id,
    required this.fullName,
    required this.rating,
    required this.email,
    this.image,
    this.phone,
  });

  factory DriverModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return DriverModel.empty();
    return DriverModel(
      id: JsonHelper.stringVal(json['_id']),
      fullName: JsonHelper.stringVal(json['fullName']),
      email: JsonHelper.stringVal(json['email']),
      rating: JsonHelper.doubleVal(json['ratting']),
      image: JsonHelper.stringVal(json['driverImage']),
      phone: JsonHelper.stringVal(json['phone']),
    );
  }

  factory DriverModel.empty() => DriverModel(
    id: '',
    fullName: '',
    email: '',
    rating: 0.0,
    image: null,
    phone: null,
  );
}

class TripModel {
  final String id;
  final LocationWithAddressModel pickupLocation;
  final LocationWithAddressModel dropoffLocation;
  final VehicleModel vehicle;
  final double distance;
  final int estimatedDuration;
  final DateTime departureTime;
  final double pricePerSeat;
  final String status;
  final String description;

  TripModel({
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.vehicle,
    required this.distance,
    required this.estimatedDuration,
    required this.departureTime,
    required this.pricePerSeat,
    required this.status,
    required this.description,
  });

  factory TripModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return TripModel.empty();
    return TripModel(
      id: JsonHelper.stringVal(json['_id']),
      pickupLocation: LocationWithAddressModel.fromJson(json['pickupLocation']),
      dropoffLocation: LocationWithAddressModel.fromJson(
        json['dropoffLocation'],
      ),
      vehicle: VehicleModel.fromJson(json['vehicle']),
      distance: JsonHelper.doubleVal(json['distance']),
      estimatedDuration: JsonHelper.intVal(json['estimatedDuration']),
      departureTime: JsonHelper.parseDate(json['departureTime']),
      pricePerSeat: JsonHelper.doubleVal(json['pricePerSeat']),
      status: JsonHelper.stringVal(json['status']),
      description: JsonHelper.stringVal(json['description']),
    );
  }

  factory TripModel.empty() => TripModel(
    id: '',
    pickupLocation: LocationWithAddressModel.empty(),
    dropoffLocation: LocationWithAddressModel.empty(),
    vehicle: VehicleModel.empty(),
    distance: 0.0,
    estimatedDuration: 0,
    departureTime: DateTime.fromMillisecondsSinceEpoch(0),
    pricePerSeat: 0.0,
    status: '',
    description: '',
  );
}

class VehicleModel {
  final String id;
  final int year;
  final String vehicleModel;
  final String brand;
  final String licensePlateNumber;
  final List<String> vehicleImages;

  VehicleModel({
    required this.id,
    required this.year,
    required this.vehicleModel,
    required this.brand,
    required this.licensePlateNumber,
    required this.vehicleImages,
  });

  factory VehicleModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return VehicleModel.empty();
    return VehicleModel(
      id: JsonHelper.stringVal(json['_id']),
      year: JsonHelper.intVal(json['year']),
      brand: JsonHelper.stringVal(json['brand']),
      licensePlateNumber: JsonHelper.stringVal(json['licensePlateNumber']),
      vehicleModel: JsonHelper.stringVal(json['vehicleModel']),
      vehicleImages:
          (json['vehicleImages'] as List?)?.map((e) => e.toString()).toList() ??
          [],
    );
  }

  factory VehicleModel.empty() => VehicleModel(
    id: '',
    year: 0,
    vehicleModel: '',
    brand: '',
    licensePlateNumber: '',
    vehicleImages: [],
  );
}

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
}
