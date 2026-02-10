// ignore_for_file: library_private_types_in_public_api

import 'package:velozaje/models/location_model.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';

class DriverEarningsSummary {
  final bool success;
  final String message;
  final int totalTrips;
  final double totalFare;
  final double totalCommission;
  final double totalEarnings;
  final double pendingPayments;
  final double completedPayments;

  DriverEarningsSummary({
    required this.success,
    required this.message,
    required this.totalTrips,
    required this.totalFare,
    required this.totalCommission,
    required this.totalEarnings,
    required this.pendingPayments,
    required this.completedPayments,
  });

  factory DriverEarningsSummary.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return DriverEarningsSummary(
      success: json['success'],
      message: json['message'],
      totalTrips: data['totalTrips'] ?? 0,
      totalFare: (data['totalFare'] ?? 0).toDouble(),
      totalCommission: (data['totalCommission'] ?? 0).toDouble(),
      totalEarnings: (data['totalEarnings'] ?? 0).toDouble(),
      pendingPayments: (data['pendingPayments'] ?? 0).toDouble(),
      completedPayments: (data['completedPayments'] ?? 0).toDouble(),
    );
  }
}

class DriverEarningsResponse {
  final bool success;
  final String message;
  final _EarningsData data;

  DriverEarningsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DriverEarningsResponse.fromJson(Map<String, dynamic> json) {
    return DriverEarningsResponse(
      success: json['success'],
      message: json['message'],
      data: _EarningsData.fromJson(json['data']),
    );
  }

  _EarningsData get earningsData => data; // expose data if needed
}

class _EarningsData {
  final List<EarningModel> earnings;
  final PaginationMetaModel pagination;

  _EarningsData({required this.earnings, required this.pagination});

  factory _EarningsData.fromJson(Map<String, dynamic> json) {
    return _EarningsData(
      earnings: (json['earnings'] as List)
          .map((e) => EarningModel.fromJson(e))
          .toList(),
      pagination: PaginationMetaModel.fromJson(json['pagination']),
    );
  }
}

// Public model
class EarningModel {
  final String id;
  final _Booking booking;
  final _Trip trip;
  final String driver;
  final _Passenger passenger;
  final double tripFare;
  final double commissionRate;
  final double commission;
  final double driverEarnings;
  final int seatsBooked;
  final String distance;
  final String duration;
  final String passengerPaymentMethod;
  final String passengerPaymentStatus;
  final String commissionPaymentStatus;
  final DateTime completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? commissionPaidAt;

  EarningModel({
    required this.id,
    required this.booking,
    required this.trip,
    required this.driver,
    required this.passenger,
    required this.tripFare,
    required this.commissionRate,
    required this.commission,
    required this.driverEarnings,
    required this.seatsBooked,
    required this.distance,
    required this.duration,
    required this.passengerPaymentMethod,
    required this.passengerPaymentStatus,
    required this.commissionPaymentStatus,
    required this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    this.commissionPaidAt,
  });

  factory EarningModel.fromJson(Map<String, dynamic> json) {
    return EarningModel(
      id: json['_id'],
      booking: _Booking.fromJson(json['booking']),
      trip: _Trip.fromJson(json['trip']),
      driver: json['driver'],
      passenger: _Passenger.fromJson(json['passenger']),
      tripFare: (json['tripFare'] as num).toDouble(),
      commissionRate: (json['commissionRate'] as num).toDouble(),
      commission: (json['commission'] as num).toDouble(),
      driverEarnings: (json['driverEarnings'] as num).toDouble(),
      seatsBooked: json['seatsBooked'],
      distance: json['distance'],
      duration: json['duration'],
      passengerPaymentMethod: json['passengerPaymentMethod'],
      passengerPaymentStatus: json['passengerPaymentStatus'],
      commissionPaymentStatus: json['commissionPaymentStatus'],
      completedAt: DateTime.parse(json['completedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      commissionPaidAt: json['commissionPaidAt'] != null
          ? DateTime.parse(json['commissionPaidAt'])
          : null,
    );
  }

  // Optional: getters to access private nested models if needed
  _Booking get bookingData => booking;
  _Trip get tripData => trip;
  _Passenger get passengerData => passenger;
}

// Private nested models
class _Booking {
  final String id;
  final String status;
  final String paymentStatus;

  _Booking({
    required this.id,
    required this.status,
    required this.paymentStatus,
  });

  factory _Booking.fromJson(Map<String, dynamic> json) {
    return _Booking(
      id: json['_id'],
      status: json['status'],
      paymentStatus: json['paymentStatus'],
    );
  }
}

class _Trip {
  final String id;
  final LocationWithAddressModel pickupLocation;
  final LocationWithAddressModel dropoffLocation;

  _Trip({
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
  });

  factory _Trip.fromJson(Map<String, dynamic> json) {
    return _Trip(
      id: json['_id'],
      pickupLocation: LocationWithAddressModel.fromJson(json['pickupLocation']),
      dropoffLocation: LocationWithAddressModel.fromJson(
        json['dropoffLocation'],
      ),
    );
  }
}

class _Passenger {
  final String id;
  final String fullName;
  final String email;

  _Passenger({required this.id, required this.fullName, required this.email});

  factory _Passenger.fromJson(Map<String, dynamic> json) {
    return _Passenger(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
    );
  }
}
