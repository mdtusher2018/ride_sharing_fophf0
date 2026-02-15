import 'package:google_places_flutter/model/place_details.dart';

class SavedLocation {
  final Location coordinates;
  final String id;
  final String user;
  final String placeName;
  final String address;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;

  SavedLocation({
    required this.coordinates,
    required this.id,
    required this.user,
    required this.placeName,
    required this.address,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SavedLocation.fromJson(Map<String, dynamic> json) {
    return SavedLocation(
      coordinates: Location.fromJson(json['coordinates']),
      id: json['_id'],
      user: json['user'],
      placeName: json['placeName'],
      address: json['address'],
      category: json['category'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
