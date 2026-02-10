import 'package:flutter/material.dart';

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

enum BookingType { travel, package }
