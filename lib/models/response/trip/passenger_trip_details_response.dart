import 'package:velozaje/models/response/trip/passenger_trip_model.dart';

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
      success: json['success'],
      message: json['message'],
      data: _TripData.fromJson(json['data']),
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
    var passengers = (json['passengers'] as List)
        .map((e) => Passenger.fromJson(e))
        .toList();
    return _TripData(
      trip: PassengerTripModel.fromJson(json['trip']),
      passengers: passengers,
      totalPassengers: json['totalPassengers'],
    );
  }
}

class Passenger {
  final PassengerDetails passenger;
  final int seatsBooked;
  final String bookingType;
  final String status;
  final DateTime bookedAt;

  Passenger({
    required this.passenger,
    required this.seatsBooked,
    required this.bookingType,
    required this.status,
    required this.bookedAt,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      passenger: PassengerDetails.fromJson(json['passenger']),
      seatsBooked: json['seatsBooked'],
      bookingType: json['bookingType'],
      status: json['status'],
      bookedAt: DateTime.parse(json['bookedAt']),
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
      id: json['_id'],
      fullName: json['fullName'],
      image: json['image'] ?? "",
      email: json['email'],
      emailVerified: json['emailVerified'],
    );
  }
}
