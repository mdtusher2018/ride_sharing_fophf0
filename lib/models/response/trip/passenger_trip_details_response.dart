import 'package:velozaje/models/response/trip/passenger_trip_model.dart';

// class PassengerTripDetailsResponse {
//   final bool success;
//   final String message;
//   final _TripData data;
//   PassengerTripDetailsResponse({
//     required this.success,
//     required this.message,
//     required this.data,
//   });
//   factory PassengerTripDetailsResponse.fromJson(Map<String, dynamic> json) {
//     return PassengerTripDetailsResponse(
//       success: json['success'],
//       message: json['message'],
//       data: _TripData.fromJson(json['data']),
//     );
//   }
// }
// class _TripData {
//   final PassengerTripModel trip;
//   final List<Passenger> passengers;
//   final int totalPassengers;
//   _TripData({
//     required this.trip,
//     required this.passengers,
//     required this.totalPassengers,
//   });
//   factory _TripData.fromJson(Map<String, dynamic> json) {
//     var passengers = (json['passengers'] as List)
//         .map((e) => Passenger.fromJson(e))
//         .toList();
//     return _TripData(
//       trip: PassengerTripModel.fromJson(json['trip']),
//       passengers: passengers,
//       totalPassengers: json['totalPassengers'],
//     );
//   }
// }
// class Passenger {
//   final PassengerDetails passenger;
//   final int? seatsBooked;
//   final String bookingType;
//   final String status;
//   final DateTime bookedAt;
//   Passenger({
//     required this.passenger,
//     required this.seatsBooked,
//     required this.bookingType,
//     required this.status,
//     required this.bookedAt,
//   });
//   factory Passenger.fromJson(Map<String, dynamic> json) {
//     return Passenger(
//       passenger: PassengerDetails.fromJson(json['passenger']),
//       seatsBooked: json['seatsBooked'],
//       bookingType: json['bookingType'],
//       status: json['status'],
//       bookedAt: DateTime.parse(json['bookedAt']),
//     );
//   }
// }
// class PassengerDetails {
//   final String id;
//   final String fullName;
//   final String image;
//   final String email;
//   final bool emailVerified;
//   PassengerDetails({
//     required this.id,
//     required this.fullName,
//     required this.image,
//     required this.email,
//     required this.emailVerified,
//   });
//   factory PassengerDetails.fromJson(Map<String, dynamic> json) {
//     return PassengerDetails(
//       id: json['_id'],
//       fullName: json['fullName'],
//       image: json['image'] ?? "",
//       email: json['email'],
//       emailVerified: json['emailVerified'],
//     );
//   }
// }

import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class PassengerTripDetailsResponse {
  final bool success;
  final String message;
  final _TripData data;

  PassengerTripDetailsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PassengerTripDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PassengerTripDetailsResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: json['data'] is Map<String, dynamic>
          ? _TripData.fromJson(json['data'])
          : _TripData.empty(),
    );
  }
}

class _TripData {
  final PassengerTripModel trip;
  final List<Passenger> passengers;
  final int totalPassengers;

  _TripData({
    required this.trip,
    required this.passengers,
    required this.totalPassengers,
  });

  factory _TripData.fromJson(Map<String, dynamic> json) {
    return _TripData(
      trip: json['trip'] is Map<String, dynamic>
          ? PassengerTripModel.fromJson(json['trip'])
          : PassengerTripModel.empty(),
      passengers:
          (json['passengers'] as List?)
              ?.map(
                (e) => e is Map<String, dynamic> ? Passenger.fromJson(e) : null,
              )
              .whereType<Passenger>()
              .toList() ??
          [],
      totalPassengers: JsonHelper.intVal(json['totalPassengers']),
    );
  }

  factory _TripData.empty() => _TripData(
    trip: PassengerTripModel.empty(),
    passengers: [],
    totalPassengers: 0,
  );
}

class Passenger {
  final PassengerDetails passenger;
  final int? seatsBooked;
  final String bookingType;
  final String status;
  final DateTime bookedAt;

  Passenger({
    required this.passenger,
    this.seatsBooked,
    required this.bookingType,
    required this.status,
    required this.bookedAt,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      passenger: json['passenger'] is Map<String, dynamic>
          ? PassengerDetails.fromJson(json['passenger'])
          : PassengerDetails.empty(),
      seatsBooked: JsonHelper.intVal(json['seatsBooked']),
      bookingType: JsonHelper.stringVal(json['bookingType']),
      status: JsonHelper.stringVal(json['status']),
      bookedAt: JsonHelper.parseDate(json['bookedAt']),
    );
  }
}

class PassengerDetails {
  final String id;
  final String fullName;
  final String image;
  final String email;
  final bool emailVerified;

  PassengerDetails({
    required this.id,
    required this.fullName,
    required this.image,
    required this.email,
    required this.emailVerified,
  });

  factory PassengerDetails.fromJson(Map<String, dynamic> json) {
    return PassengerDetails(
      id: JsonHelper.stringVal(json['_id']),
      fullName: JsonHelper.stringVal(json['fullName']),
      image: JsonHelper.stringVal(json['image']),
      email: JsonHelper.stringVal(json['email']),
      emailVerified: JsonHelper.boolVal(json['emailVerified']),
    );
  }

  factory PassengerDetails.empty() => PassengerDetails(
    id: '',
    fullName: '',
    image: '',
    email: '',
    emailVerified: false,
  );
}
