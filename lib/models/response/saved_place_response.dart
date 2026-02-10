import 'package:google_places_flutter/model/place_details.dart';

class SavedLocationsResponse {
  final bool success;
  final String message;
  final SavedLocationsData data;

  SavedLocationsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SavedLocationsResponse.fromJson(Map<String, dynamic> json) {
    return SavedLocationsResponse(
      success: json['success'],
      message: json['message'],
      data: SavedLocationsData.fromJson(json['data']),
    );
  }
}

class SavedLocationsData {
  final List<SavedLocation> savedPlaces;

  SavedLocationsData({required this.savedPlaces});

  factory SavedLocationsData.fromJson(Map<String, dynamic> json) {
    return SavedLocationsData(
      savedPlaces: (json['savedPlaces'] as List)
          .map((e) => SavedLocation.fromJson(e))
          .toList(),
    );
  }
}

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
