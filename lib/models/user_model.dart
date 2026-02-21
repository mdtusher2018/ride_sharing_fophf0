import 'package:google_places_flutter/model/place_details.dart';
import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class UserModel {
  final String id;
  final String fullName;
  final String image;
  final String email;
  final String about;
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
    required this.about,
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
      about: JsonHelper.stringVal(json['about']),
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
