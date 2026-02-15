// ignore_for_file: library_private_types_in_public_api

import 'package:velozaje/core/utils/api_data_praser_helper.dart';
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
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: json['data'] is Map<String, dynamic>
          ? _DriverTripsData.fromJson(json['data'])
          : _DriverTripsData.empty(),
    );
  }

  _DriverTripsData get driverTripsData => data;
}

//
// 🔹 DRIVER TRIPS DATA
//

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
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: json['data'] is Map<String, dynamic>
          ? _TripsData.fromJson(json['data'])
          : _TripsData.empty(),
    );
  }

  factory _DriverTripsData.empty() {
    return _DriverTripsData(
      success: false,
      message: '',
      data: _TripsData.empty(),
    );
  }

  List<DriverTripModel> get trips => _data.trips;
  PaginationMetaModel get pagination => _data.pagination;
}

//
// 🔹 TRIPS + PAGINATION
//

class _TripsData {
  final List<DriverTripModel> trips;
  final PaginationMetaModel pagination;

  _TripsData({required this.trips, required this.pagination});

  factory _TripsData.fromJson(Map<String, dynamic> json) {
    return _TripsData(
      trips: json['trips'] is List
          ? (json['trips'] as List)
                .map(
                  (e) => e is Map<String, dynamic>
                      ? DriverTripModel.fromJson(e)
                      : null,
                )
                .whereType<DriverTripModel>()
                .toList()
          : [],
      pagination: json['pagination'] is Map<String, dynamic>
          ? PaginationMetaModel.fromJson(json['pagination'])
          : PaginationMetaModel.empty(),
    );
  }

  factory _TripsData.empty() {
    return _TripsData(trips: [], pagination: PaginationMetaModel.empty());
  }
}

//
// 🔹 DRIVER TRIP MODEL
//

class DriverTripModel {
  final String id;
  final LocationWithAddressModel pickupLocation;
  final LocationWithAddressModel dropoffLocation;
  final String driverId;
  final _Vehicle vehicle;
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
  final TripStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DriverTripModel({
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.driverId,
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

  factory DriverTripModel.fromJson(Map<String, dynamic> json) {
    return DriverTripModel(
      id: JsonHelper.stringVal(json['_id']),

      pickupLocation: LocationWithAddressModel.fromJson(
        json['pickupLocation'] ?? {},
      ),

      dropoffLocation: LocationWithAddressModel.fromJson(
        json['dropoffLocation'] ?? {},
      ),

      driverId: JsonHelper.stringVal(json['driver']),

      vehicle: json['vehicle'] is Map<String, dynamic>
          ? _Vehicle.fromJson(json['vehicle'])
          : _Vehicle.empty(),

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

      status: JsonHelper.stringVal(json['status']).toTripStatus(),

      createdAt: JsonHelper.parseDate(json['createdAt']),

      updatedAt: JsonHelper.parseDate(json['updatedAt']),
    );
  }
}

//
// 🔹 PRIVATE VEHICLE MODEL
//

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
      id: JsonHelper.stringVal(json['_id']),
      year: JsonHelper.intVal(json['year']),
      vehicleModel: JsonHelper.stringVal(json['vehicleModel']),
      vehicleImages: json['vehicleImages'] is List
          ? List<String>.from(json['vehicleImages'].map((e) => e.toString()))
          : [],
    );
  }

  factory _Vehicle.empty() {
    return _Vehicle(id: '', year: 0, vehicleModel: '', vehicleImages: []);
  }
}
