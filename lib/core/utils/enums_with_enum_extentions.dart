import 'package:flutter/material.dart';

enum BookingType { travel, package }

enum OTPVerificationPurpose { emailVerify, forgotPassword }

enum BookingStatus {
  pending,
  confirmed,
  inProgress,
  completed,
  cancelled,
  unknown,
}

enum TripStatus { scheduled, inProgress, completed, cancelled, unknown }

extension TripStatusParser on String? {
  TripStatus toTripStatus() {
    switch (this) {
      case 'scheduled':
        return TripStatus.scheduled;
      case 'in-progress':
      case 'inProgress':
        return TripStatus.inProgress;
      case 'completed':
        return TripStatus.completed;
      case 'cancelled':
        return TripStatus.cancelled;
      default:
        return TripStatus.unknown;
    }
  }
}

extension TripStatusUI on TripStatus {
  String label(BuildContext context) {
    switch (this) {
      case TripStatus.scheduled:
        return "Scheduled";
      case TripStatus.inProgress:
        return "In Progress";
      case TripStatus.completed:
        return "Completed";
      case TripStatus.cancelled:
        return "Cancelled";
      default:
        return "Unknown";
    }
  }

  Color color() {
    switch (this) {
      case TripStatus.scheduled:
        return Color(0xFFB59100);
      case TripStatus.inProgress:
        return Colors.blue;
      case TripStatus.completed:
        return Colors.green;
      case TripStatus.cancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

extension BookingStatusParser on String? {
  BookingStatus toBookingStatus() {
    switch (this?.toLowerCase()) {
      case 'confirmed':
        return BookingStatus.confirmed;

      case 'pending':
        return BookingStatus.pending;

      case 'in-progress':
      case 'inprogress':
        return BookingStatus.inProgress;

      case 'completed':
        return BookingStatus.completed;

      case 'cancelled':
      case 'canceled':
        return BookingStatus.cancelled;

      default:
        return BookingStatus.unknown;
    }
  }
}
