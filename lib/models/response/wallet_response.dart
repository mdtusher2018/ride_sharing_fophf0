import 'package:velozaje/core/utils/api_data_praser_helper.dart';
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
  final List<EarningModel> earnings;
  final PaginationMetaModel pagination;

  DriverEarningsResponse({required this.earnings, required this.pagination});

  factory DriverEarningsResponse.fromJson(Map<String, dynamic> json) {
    return DriverEarningsResponse(
      earnings: (json['data']['earnings'] as List)
          .map((e) => EarningModel.fromJson(e))
          .toList(),
      pagination: PaginationMetaModel.fromJson(json['pagination']),
    );
  }
}

class EarningModel {
  final String bookingId;
  final String tripId;
  final double totalPrice;
  final double driverEarnings;
  final double commission;
  final String paymentStatus;
  final String pickupLocation;
  final String dropoffLocation;
  final DateTime completedAt;

  EarningModel({
    required this.bookingId,
    required this.tripId,
    required this.totalPrice,
    required this.driverEarnings,
    required this.commission,
    required this.paymentStatus,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.completedAt,
  });

  factory EarningModel.fromJson(Map<String, dynamic> json) {
    return EarningModel(
      bookingId: JsonHelper.stringVal(json['booking']['_id']),
      tripId: JsonHelper.stringVal(json['trip']),
      totalPrice: JsonHelper.doubleVal(json['booking']['totalPrice']),
      driverEarnings: JsonHelper.doubleVal(json['driverEarnings']),
      commission: JsonHelper.doubleVal(json['commission']),
      paymentStatus: JsonHelper.stringVal(json['booking']['paymentStatus']),
      pickupLocation: JsonHelper.stringVal(
        json['booking']['pickupLocation']['address'],
      ),
      dropoffLocation: JsonHelper.stringVal(
        json['booking']['dropoffLocation']['address'],
      ),
      completedAt: JsonHelper.parseDate(json['completedAt']),
    );
  }
}
