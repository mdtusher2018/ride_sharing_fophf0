import 'package:velozaje/core/utils/api_data_praser_helper.dart';
import 'package:velozaje/models/location_model.dart';

class PassengerTripModel {
  final String id;
  final LocationWithAddressModel pickupLocation;
  final LocationWithAddressModel dropoffLocation;
  final _Driver? driver;
  final _Vehicle? vehicle;
  final String routePolyline;
  final double distance;
  final double estimatedDuration;
  final String driverImage;
  final DateTime? departureTime;
  final double pricePerSeat;
  final int totalSeats;
  final int availableSeats;
  final int bookedSeats;
  final String description;
  final bool automaticReservation;
  final bool packageDeliveryEnabled;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic> packages;

  PassengerTripModel({
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
    this.driver,
    this.vehicle,
    required this.routePolyline,
    required this.distance,
    required this.estimatedDuration,
    required this.driverImage,
    this.departureTime,
    required this.pricePerSeat,
    required this.totalSeats,
    required this.availableSeats,
    required this.bookedSeats,
    required this.description,
    required this.automaticReservation,
    required this.packageDeliveryEnabled,
    required this.status,
    this.createdAt,
    this.updatedAt,
    required this.packages,
  });

  factory PassengerTripModel.fromJson(Map<String, dynamic> json) {
    return PassengerTripModel(
      id: JsonHelper.stringVal(json['_id']),
      pickupLocation: LocationWithAddressModel.fromJson(
        json['pickupLocation'] ?? {},
      ),
      dropoffLocation: LocationWithAddressModel.fromJson(
        json['dropoffLocation'] ?? {},
      ),
      driver: json['driver'] is Map<String, dynamic>
          ? _Driver.fromJson(json['driver'])
          : null,
      vehicle: json['vehicle'] is Map<String, dynamic>
          ? _Vehicle.fromJson(json['vehicle'])
          : null,
      routePolyline: JsonHelper.stringVal(json['routePolyline']),
      distance: JsonHelper.doubleVal(json['distance']),
      estimatedDuration: JsonHelper.doubleVal(json['estimatedDuration']),
      driverImage: JsonHelper.stringVal(json['driverImage']),
      departureTime: JsonHelper.parseDate(json['departureTime']),
      pricePerSeat: JsonHelper.doubleVal(json['pricePerSeat']),
      totalSeats: JsonHelper.intVal(json['totalSeats']),
      availableSeats: JsonHelper.intVal(json['availableSeats']),
      bookedSeats: JsonHelper.intVal(json['bookedSeats']),
      description: JsonHelper.stringVal(json['description']),
      automaticReservation: JsonHelper.boolVal(json['automaticReservation']),
      packageDeliveryEnabled: JsonHelper.boolVal(
        json['packageDeliveryEnabled'],
      ),
      status: JsonHelper.stringVal(json['status']),
      createdAt: JsonHelper.parseDate(json['createdAt']),
      updatedAt: JsonHelper.parseDate(json['updatedAt']),
      packages: json['packages'] is List ? json['packages'] : [],
    );
  }

  /// 🔹 Empty instance for safe defaults
  factory PassengerTripModel.empty() => PassengerTripModel(
    id: '',
    pickupLocation: LocationWithAddressModel(
      coordinates: LocationModel(type: '', longitude: 0, latitude: 0),
      address: '',
    ),
    dropoffLocation: LocationWithAddressModel(
      coordinates: LocationModel(type: '', longitude: 0, latitude: 0),
      address: '',
    ),
    driver: null,
    vehicle: null,
    routePolyline: '',
    distance: 0.0,
    estimatedDuration: 0.0,
    driverImage: '',
    departureTime: null,
    pricePerSeat: 0.0,
    totalSeats: 0,
    availableSeats: 0,
    bookedSeats: 0,
    description: '',
    automaticReservation: false,
    packageDeliveryEnabled: false,
    status: '',
    createdAt: null,
    updatedAt: null,
    packages: [],
  );
}

class _Driver {
  final String id;
  final String fullName;
  final String email;
  final String image;
  final String phone;
  final bool isActive;
  final double ratting;

  _Driver({
    required this.id,
    required this.fullName,
    required this.email,
    required this.image,
    required this.phone,
    required this.isActive,
    required this.ratting,
  });

  factory _Driver.fromJson(Map<String, dynamic> json) {
    return _Driver(
      id: JsonHelper.stringVal(json['_id']),
      fullName: JsonHelper.stringVal(json['fullName']),
      email: JsonHelper.stringVal(json['email']),
      image: JsonHelper.stringVal(json['image']),
      phone: JsonHelper.stringVal(json['phone']),
      isActive: JsonHelper.boolVal(json['isActive']),
      ratting: JsonHelper.doubleVal(json['ratting']),
    );
  }
}

class _Vehicle {
  final String id;
  final int year;
  final String vehicleModel;
  final String brand;
  final String licensePlateNumber;
  final List<String> vehicleImages;

  _Vehicle({
    required this.id,
    required this.year,
    required this.vehicleModel,
    required this.brand,
    required this.licensePlateNumber,
    required this.vehicleImages,
  });

  factory _Vehicle.fromJson(Map<String, dynamic> json) {
    return _Vehicle(
      id: JsonHelper.stringVal(json['_id']),
      year: JsonHelper.intVal(json['year']),
      vehicleModel: JsonHelper.stringVal(json['vehicleModel']),
      brand: JsonHelper.stringVal(json['brand']),
      licensePlateNumber: JsonHelper.stringVal(json['licensePlateNumber']),
      vehicleImages: json['vehicleImages'] is List
          ? List<String>.from(json['vehicleImages'].map((e) => e.toString()))
          : [],
    );
  }
}
