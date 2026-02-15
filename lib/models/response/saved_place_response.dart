import 'package:velozaje/models/save_location_model.dart';

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
