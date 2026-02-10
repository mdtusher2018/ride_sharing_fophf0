// ignore_for_file: library_private_types_in_public_api

import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/models/location_model.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';

class DriverTripsResponse {
  final bool success;
  final String message;
  final _DriverTripsData data;

  DriverTripsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DriverTripsResponse.fromJson(Map<String, dynamic> json) {
    return DriverTripsResponse(
      success: json['success'],
      message: json['message'],
      data: _DriverTripsData.fromJson(json['data']),
    );
  }

  _DriverTripsData get driverTripsData => data; // expose data if needed
}

class _DriverTripsData {
  final bool success;
  final String message;
  final _TripsData _data;

  _DriverTripsData({
    required this.success,
    required this.message,
    required _TripsData data,
  }) : _data = data;

  factory _DriverTripsData.fromJson(Map<String, dynamic> json) {
    return _DriverTripsData(
      success: json['success'],
      message: json['message'],
      data: _TripsData.fromJson(json['data']),
    );
  }

  List<DriverTripModel> get trips => _data.trips;
  PaginationMetaModel get pagination => _data.pagination;
}

// Private inner class for trips list + pagination
class _TripsData {
  final List<DriverTripModel> trips;
  final PaginationMetaModel pagination;

  _TripsData({required this.trips, required this.pagination});

  factory _TripsData.fromJson(Map<String, dynamic> json) {
    return _TripsData(
      trips: (json['trips'] as List)
          .map((e) => DriverTripModel.fromJson(e))
          .toList(),
      pagination: PaginationMetaModel.fromJson(json['pagination']),
    );
  }
}

class DriverTripModel {
  final String id;
  final LocationWithAddressModel pickupLocation;
  final LocationWithAddressModel dropoffLocation;
  final String driverId;
  final _Vehicle _vehicle;
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
  final TripStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  DriverTripModel({
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.driverId,
    required _Vehicle vehicle,
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
  }) : _vehicle = vehicle;

  _Vehicle get vehicle => _vehicle;

  factory DriverTripModel.fromJson(Map<String, dynamic> json) {
    return DriverTripModel(
      id: json['_id'],
      pickupLocation: LocationWithAddressModel.fromJson(json['pickupLocation']),
      dropoffLocation: LocationWithAddressModel.fromJson(
        json['dropoffLocation'],
      ),
      driverId: json['driver'],
      vehicle: _Vehicle.fromJson(json['vehicle']),
      routePolyline: json['routePolyline'],
      distance: (json['distance'] as num).toDouble(),
      estimatedDuration: json['estimatedDuration'],
      driverImage: json['driverImage'],
      departureTime: DateTime.parse(json['departureTime']),
      pricePerSeat: json['pricePerSeat'],
      totalSeats: json['totalSeats'],
      availableSeats: json['availableSeats'],
      bookedSeats: json['bookedSeats'],
      description: json['description'],
      automaticReservation: json['automaticReservation'],
      packageDeliveryEnabled: json['packageDeliveryEnabled'],
      status: (json['status'] ?? "").toString().toTripStatus(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

// Private vehicle model
class _Vehicle {
  final String id;
  final num year;
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
      id: json['_id'],
      year: json['year'],
      vehicleModel: json['vehicleModel'],
      vehicleImages: List<String>.from(json['vehicleImages']),
    );
  }
}
