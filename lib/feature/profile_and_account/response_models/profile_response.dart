import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class UserProfileResponse {
  final bool success;
  final String message;
  final UserModel? data;

  UserProfileResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: json['data'] != null ? UserModel.fromJson(json['data']) : null,
    );
  }
}

class UserModel {
  final String id;
  final String fullName;
  final String image;
  final String email;
  final Location? currentLocation;
  final List<String> roles;
  final bool emailVerified;
  final bool isActive;
  final bool isLocked;
  final int version;
  final int due;
  final int tripCount;
  final int bookingCount;
  final int packageDelivered;
  final int packageSent;
  final int travelCount;

  UserModel({
    required this.id,
    required this.fullName,
    required this.image,
    required this.email,
    this.currentLocation,
    required this.roles,
    required this.emailVerified,
    required this.isActive,
    required this.isLocked,
    required this.version,
    required this.due,
    required this.tripCount,
    required this.bookingCount,
    required this.packageDelivered,
    required this.packageSent,
    required this.travelCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: JsonHelper.stringVal(json['_id']),
      fullName: JsonHelper.stringVal(json['fullName']),
      image: JsonHelper.stringVal(json['image']),
      email: JsonHelper.stringVal(json['email']),
      currentLocation: json['currentLocation'] != null
          ? Location.fromJson(json['currentLocation'])
          : null,
      roles: (json['roles'] as List? ?? [])
          .map((e) => JsonHelper.stringVal(e))
          .toList(),
      emailVerified: JsonHelper.boolVal(json['emailVerified']),
      isActive: JsonHelper.boolVal(json['isActive']),
      isLocked: JsonHelper.boolVal(json['isLocked']),
      version: JsonHelper.intVal(json['__v']),
      due: JsonHelper.intVal(json['due']),
      tripCount: JsonHelper.intVal(json['tripCount']),
      bookingCount: JsonHelper.intVal(json['bookingCount']),
      packageDelivered: JsonHelper.intVal(json['packageDelivered']),
      packageSent: JsonHelper.intVal(json['packageSent']),
      travelCount: JsonHelper.intVal(json['travelCount']),
    );
  }
}

class Location {
  final String type;
  final double longitude;
  final double latitude;

  Location({
    required this.type,
    required this.longitude,
    required this.latitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    final coords = (json['coordinates'] as List? ?? []);

    return Location(
      type: JsonHelper.stringVal(json['type']),
      longitude: coords.isNotEmpty ? JsonHelper.doubleVal(coords[0]) : 0.0,
      latitude: coords.length > 1 ? JsonHelper.doubleVal(coords[1]) : 0.0,
    );
  }
}
