// trips_response.dart
import 'package:velozaje/models/pagenation_meta_model.dart';
import 'package:velozaje/models/response/trip/passenger_trip_model.dart';

class PassengerTripsResponse {
  final bool success;
  final String message;
  final _TripsWrapper data;

  PassengerTripsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PassengerTripsResponse.fromJson(Map<String, dynamic> json) {
    return PassengerTripsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] is Map<String, dynamic>
          ? _TripsWrapper.fromJson(json['data'])
          : _TripsWrapper.empty(),
    );
  }
}

class _TripsWrapper {
  final bool success;
  final String message;
  final _TripsData data;

  _TripsWrapper({
    required this.success,
    required this.message,
    required this.data,
  });

  factory _TripsWrapper.fromJson(Map<String, dynamic> json) {
    return _TripsWrapper(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] is Map<String, dynamic>
          ? _TripsData.fromJson(json['data'])
          : _TripsData.empty(),
    );
  }

  factory _TripsWrapper.empty() {
    return _TripsWrapper(success: false, message: '', data: _TripsData.empty());
  }

  List<PassengerTripModel> get trips => data.trips;
  PaginationMetaModel get pagination => data.pagination;
}

// Private inner class for trips list + pagination
class _TripsData {
  final List<PassengerTripModel> trips;
  final PaginationMetaModel pagination;

  _TripsData({required this.trips, required this.pagination});

  factory _TripsData.fromJson(Map<String, dynamic> json) {
    return _TripsData(
      trips: (json['trips'] as List<dynamic>? ?? [])
          .map(
            (e) => e is Map<String, dynamic>
                ? PassengerTripModel.fromJson(e)
                : PassengerTripModel.empty(),
          )
          .toList(),
      pagination: json['pagination'] is Map<String, dynamic>
          ? PaginationMetaModel.fromJson(json['pagination'])
          : PaginationMetaModel.empty(),
    );
  }

  factory _TripsData.empty() =>
      _TripsData(trips: [], pagination: PaginationMetaModel.empty());
}
