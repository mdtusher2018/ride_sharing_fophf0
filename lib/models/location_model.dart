import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class LocationModel {
  final String type;
  final double longitude;
  final double latitude;

  LocationModel({
    required this.type,
    required this.longitude,
    required this.latitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    final coords = (json['coordinates'] as List? ?? []);

    return LocationModel(
      type: JsonHelper.stringVal(json['type']),
      longitude: coords.isNotEmpty ? JsonHelper.doubleVal(coords[0]) : 0.0,
      latitude: coords.length > 1 ? JsonHelper.doubleVal(coords[1]) : 0.0,
    );
  }
}

class LocationWithAddressModel {
  final LocationModel coordinates;
  final String address;

  LocationWithAddressModel({required this.coordinates, required this.address});

  factory LocationWithAddressModel.fromJson(Map<String, dynamic> json) {
    return LocationWithAddressModel(
      coordinates: LocationModel.fromJson(json['coordinates']),
      address: JsonHelper.stringVal(json['address']),
    );
  }
}
