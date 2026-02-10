import 'package:velozaje/models/location_model.dart';

class PassengerTripModel {
  final String id;
  final LocationWithAddressModel pickupLocation;
  final LocationWithAddressModel dropoffLocation;
  final _Driver driver;
  final _Vehicle vehicle;
  final String routePolyline;
  final num distance;
  final num estimatedDuration;
  final String driverImage;
  final DateTime departureTime;
  final num pricePerSeat;
  final num totalSeats;
  final num availableSeats;
  final num bookedSeats;
  final String description;
  final bool automaticReservation;
  final bool packageDeliveryEnabled;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  PassengerTripModel({
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.driver,
    required this.vehicle,
    required this.routePolyline,
    required this.distance,
    required this.estimatedDuration,
    required this.driverImage,
    required this.departureTime,
    required this.pricePerSeat,
    required this.totalSeats,
    required this.availableSeats,
    required this.bookedSeats,
    required this.description,
    required this.automaticReservation,
    required this.packageDeliveryEnabled,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PassengerTripModel.fromJson(Map<String, dynamic> json) {
    return PassengerTripModel(
      id: json['_id'],
      pickupLocation: LocationWithAddressModel.fromJson(json['pickupLocation']),
      dropoffLocation: LocationWithAddressModel.fromJson(
        json['dropoffLocation'],
      ),
      driver: _Driver.fromJson(json['driver']),
      vehicle: _Vehicle.fromJson(json['vehicle']),
      routePolyline: json['routePolyline'],
      distance: (json['distance'] as num).toDouble(),
      estimatedDuration: json['estimatedDuration'],
      driverImage: json['driverImage'],
      departureTime: DateTime.parse(json['departureTime']),
      pricePerSeat: (json['pricePerSeat'] as num).toDouble(),
      totalSeats: json['totalSeats'],
      availableSeats: json['availableSeats'],
      bookedSeats: json['bookedSeats'],
      description: json['description'],
      automaticReservation: json['automaticReservation'],
      packageDeliveryEnabled: json['packageDeliveryEnabled'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

// Private Driver model
class _Driver {
  final String id;
  final String fullName;
  final String email;
  final String image;
  final String phone;
  final bool isActive;
  final num ratting;

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
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      image: json['image'],
      phone: json['phone'],
      isActive: json['isActive'] ?? false,
      ratting: json['ratting'] ?? 0,
    );
  }
}

// Private Vehicle model
class _Vehicle {
  final String id;
  final num year;
  final String vehicleModel;
  final String brand;
  final String licensePlateNumber;

  final List<String> vehicleImages;

  _Vehicle({
    required this.id,
    required this.year,
    required this.vehicleModel,
    required this.vehicleImages,
    required this.brand,
    required this.licensePlateNumber,
  });

  factory _Vehicle.fromJson(Map<String, dynamic> json) {
    return _Vehicle(
      id: json['_id'],
      year: json['year'],
      vehicleModel: json['vehicleModel'],
      brand: json['brand'] ?? "",
      licensePlateNumber: json['licensePlateNumber'] ?? "",
      vehicleImages: List<String>.from(json['vehicleImages']),
    );
  }
}
