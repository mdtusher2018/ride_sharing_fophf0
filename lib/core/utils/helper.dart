import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:geolocator/geolocator.dart';

Future<void> checkClipboard(
  List<TextEditingController> controllers,
  List<FocusNode> _focusNodes,
) async {
  final clipboardData = await Clipboard.getData('text/plain');
  if (clipboardData != null) {
    final text = clipboardData.text ?? '';

    final otpMatch = RegExp(r'\b\d{4}\b').firstMatch(text);

    if (otpMatch != null) {
      final otp = otpMatch.group(0)!;

      for (int i = 0; i < 4; i++) {
        controllers[i].text = otp[i];
      }

      _focusNodes[3].requestFocus();
    }
  }
}

String getFullImagePath(String imagePath) {
  if (imagePath.isEmpty) {
    return "https://www.ncenet.com/wp-content/uploads/2020/04/no-image-png-2.png";
  }

  if (imagePath.startsWith('http')) {
    return imagePath;
  }
  if (imagePath.startsWith('/')) {
    return '${ApiEndpoints.baseImageUrl}$imagePath';
  }
  return '${ApiEndpoints.baseImageUrl}/$imagePath';
}

// Helper method to get current location
Future<Position?> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return null;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return null;
  }

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  return position;
}

String formatDurationInMinutes(int durationInMinutes) {
  int hours = durationInMinutes ~/ 60;
  int minutes = durationInMinutes % 60;

  String formattedDuration = '';
  if (hours > 0) {
    formattedDuration += '$hours h';
  }
  if (minutes > 0) {
    if (hours > 0) {
      formattedDuration += ' ';
    }
    formattedDuration += '$minutes min';
  }

  return formattedDuration.trim();
}

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = today.add(const Duration(days: 1));
  final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

  final timeFormat = DateFormat('hh:mm a'); // 10:25 AM

  if (date == today) {
    return 'Today, ${timeFormat.format(dateTime)}';
  } else if (date == tomorrow) {
    return 'Tomorrow, ${timeFormat.format(dateTime)}';
  } else {
    final dateFormat = DateFormat('MMM dd, yyyy, hh:mm a');
    return dateFormat.format(dateTime);
  }
}
