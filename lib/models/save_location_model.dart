import 'package:velozaje/core/utils/api_data_praser_helper.dart';
import 'package:velozaje/models/location_model.dart';

class SavedLocation {
  final LocationModel coordinates;
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

  factory SavedLocation.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('SavedLocation JSON cannot be null');
    }

    return SavedLocation(
      coordinates: LocationModel.fromJson(json['coordinates'] ?? {}),
      id: JsonHelper.stringVal(json['_id']),
      user: JsonHelper.stringVal(json['user']),
      placeName: JsonHelper.stringVal(json['placeName']),
      address: JsonHelper.stringVal(json['address']),
      category: JsonHelper.stringVal(json['category']),
      createdAt: JsonHelper.parseDate(json['createdAt']),
      updatedAt: JsonHelper.parseDate(json['updatedAt']),
    );
  }
}
