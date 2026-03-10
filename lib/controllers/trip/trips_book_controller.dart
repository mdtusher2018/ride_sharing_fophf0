import 'dart:developer';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velozaje/core/services/socket/socket_events.dart';
import 'package:velozaje/core/services/socket/socket_service.dart';
import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';
import 'package:velozaje/controllers/paginated_controller.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/request/trip_search_request.dart';
import 'package:velozaje/models/response/trip/booking_details_response.dart';
import 'package:velozaje/models/response/trip/booking_response.dart';
import 'package:velozaje/models/response/trip/passenger_trip_model.dart';
import 'package:velozaje/models/response/trip/published_trip_details_response.dart';

class TripsBookingState {
  final List<BookingsOfPublishedTrip> pendingBookings;
  final List<BookingsOfPublishedTrip> confirmedBookings;
  final LatLng? driverCurrentLocation;

  const TripsBookingState({
    this.pendingBookings = const [],
    this.confirmedBookings = const [],
    this.driverCurrentLocation,
  });

  factory TripsBookingState.initial() {
    return const TripsBookingState();
  }

  TripsBookingState copyWith({
    List<BookingsOfPublishedTrip>? pendingBookings,
    List<BookingsOfPublishedTrip>? confirmedBookings,
    LatLng? driverCurrentLocation,
  }) {
    return TripsBookingState(
      pendingBookings: pendingBookings ?? this.pendingBookings,
      confirmedBookings: confirmedBookings ?? this.confirmedBookings,
      driverCurrentLocation:
          driverCurrentLocation ?? this.driverCurrentLocation,
    );
  }
}

class TrippBookController extends PaginationNotifier<PassengerBookingModel> {
  final IApiService apiService;
  final SocketService socketService;

  TrippBookController(this.apiService, this.socketService)
    : super(extraState: TripsBookingState());

  PassengerBookingDetailsModel? bookingDetail;

  @override
  Future<(List<PassengerBookingModel>, PaginationMetaModel)> fetchPage({
    required int page,
    int limit = 10,
  }) async {
    final response = await apiService.get(
      ApiEndpoints.myBookedTrip,
      queryParameters: {"page": page.toString(), "limit": limit.toString()},
    );

    final result = PassengerBookedTripResponse.fromJson(response);

    final trips = result.data.bookings;
    final meta = result.data.pagination;

    return (trips, meta);
  }

  Future<bool?> tripBooking({
    required PassengerTripModel tripDetails,
    required TripSearchRequest tripSearched,
    required File passengerImage,
  }) async {
    // Build multipart fields map from inputs
    final Map<String, dynamic> fields = {
      'trip': tripDetails.id,
      if (tripSearched.bookingType == BookingType.travel)
        'seatsBooked': tripSearched.passengersCount.toString(),
      'bookingType': tripSearched.bookingType.name,

      'pickupLocation[address]': tripSearched.pickupAddress,
      'pickupLocation[coordinates][0]': tripSearched.pickupLatLng!.longitude
          .toString(),
      'pickupLocation[coordinates][1]': tripSearched.pickupLatLng!.latitude
          .toString(),

      'dropoffLocation[address]': tripSearched.destinationAddress,
      'dropoffLocation[coordinates][0]': tripSearched
          .destinationLatLng!
          .longitude
          .toString(),
      'dropoffLocation[coordinates][1]': tripSearched
          .destinationLatLng!
          .latitude
          .toString(),
      'paymentMethod': 'cash',
    };

    if (tripSearched.bookingType == BookingType.package &&
        tripSearched.packages.isNotEmpty) {
      for (int i = 0; i < tripSearched.packages.length; i++) {
        final package = tripSearched.packages[i];
        fields.addAll({
          'packages[$i][weight]': package.weightKg.toString(),
          'packages[$i][quantity]': tripSearched.packages.length.toString(),
          'packages[$i][dimensions][length]': package.lengthCm.toString(),
          'packages[$i][dimensions][width]': package.widthCm.toString(),
          'packages[$i][dimensions][height]': package.heightCm.toString(),
          'packages[$i][description]': 'package $i',
        });
      }
    }

    final Map<String, List<File>> files = {
      'passengerImage': [passengerImage],
    };

    return await safeCall<bool>(
      task: () async {
        await apiService.multipart(
          ApiEndpoints.bookingTrip,
          bodyFieldName: "POST",
          fields: fields,
          files: files,
        );
        return true;
      },
    );
  }

  Future<void> bookedTripDetailsById({required String id}) async {
    await safeCall(
      task: () async {
        final res = await apiService.get(
          ApiEndpoints.bookedTripDetailsById(id),
        );
        bookingDetail = PassengerBookedDetailsResponse.fromJson(res).booking;
      },
    );
  }

  void initializedBookingsOfAPublishedTrips({
    required List<BookingsOfPublishedTrip> pendingBookings,
    required List<BookingsOfPublishedTrip> confirmedBookings,
  }) {
    final extra = state.extraState as TripsBookingState;
    state = state.copyWith(
      extraState: extra.copyWith(
        pendingBookings: pendingBookings,
        confirmedBookings: confirmedBookings,
      ),
    );
  }

  Future<void> acceptBookingById({required String bookingId}) async {
    await safeCall(
      task: () async {
        await apiService.patch(ApiEndpoints.acceptBooking(bookingId), {});
      },
    );
  }

  Future<void> rejectBookingById({required String bookingId}) async {
    await safeCall(
      task: () async {
        await apiService.patch(ApiEndpoints.rejectBooking(bookingId), {});
        final extra = state.extraState as TripsBookingState;

        final updatedPending = extra.pendingBookings
            .where((e) => e.id != bookingId)
            .toList();

        state = state.copyWith(
          extraState: extra.copyWith(pendingBookings: updatedPending),
        );
      },
      showLoading: false,
    );
  }

  Future<void> cancelBookingByUser({
    required String bookingId,
    required String reason,
  }) async {
    await safeCall(
      task: () async {
        await apiService.patch(ApiEndpoints.cancelTripByUser(bookingId), {
          "reason": reason,
        });
      },
      successMessage: "Booking cancel successfully",
      showSuccessSnack: true,
      showLoading: false,
    );
  }

  Future<void> verifyOtpToStartRide({
    required String bookingId,
    required String otp,
  }) async {
    await safeCall(
      task: () async {
        await apiService.patch(ApiEndpoints.verifyOtpToStartRide(bookingId), {
          'otp': otp,
        });
      },
    );
  }

  Future<void> verifyOtpToEndRide({
    required String bookingId,
    required String otp,
  }) async {
    await safeCall(
      task: () async {
        await apiService.patch(ApiEndpoints.verifyOtpToEndRide(bookingId), {
          'otp': otp,
        });
      },
    );
  }

  void listenDriverCurrentLocation() {
    socketService.on(SocketEvents.driverLocations, (data) {
      log(data.toString());
      final lat = data["location"]["latitude"];
      final lng = data["location"]["longitude"];

      final currentExtra = (state.extraState as TripsBookingState);
      state = state.copyWith(
        extraState: currentExtra.copyWith(
          driverCurrentLocation: LatLng(lat, lng),
        ),
      );
    });
  }

  void joinTripRoom({required String bookingId, required String userId}) {
    socketService.emit(SocketEvents.joinTripRoom, {
      {"bookingId": bookingId, "userId": userId, "userRole": "user"},
    });
    listenDriverCurrentLocation();
  }
}
