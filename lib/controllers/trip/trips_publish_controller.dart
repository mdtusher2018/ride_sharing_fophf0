import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';
import 'package:velozaje/controllers/paginated_controller.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/request/trip_publish_request.dart';
import 'package:velozaje/models/response/trip/driver_published_trips.dart';
import 'package:velozaje/models/response/trip/passenger_trip_details_response.dart';
import 'package:velozaje/models/response/trip/published_trip_details_response.dart';

class TripsPublishState {
  final BookigsOfPublishedTripResponse? bookingsOfPublishedTrip;
  final PassengerTripDetailsResponse? tripDetails;

  const TripsPublishState({this.bookingsOfPublishedTrip, this.tripDetails});

  factory TripsPublishState.initial() {
    return const TripsPublishState();
  }

  TripsPublishState copyWith({
    BookigsOfPublishedTripResponse? bookingsOfPublishedTrip,
    PassengerTripDetailsResponse? tripDetails,
  }) {
    return TripsPublishState(
      bookingsOfPublishedTrip:
          bookingsOfPublishedTrip ?? this.bookingsOfPublishedTrip,
      tripDetails: tripDetails ?? this.tripDetails,
    );
  }
}

class TripsPublishController extends PaginationNotifier<DriverTripModel> {
  final IApiService apiService;

  TripsPublishController(this.apiService)
    : super(extraState: TripsPublishState());

  @override
  Future<(List<DriverTripModel>, PaginationMetaModel)> fetchPage({
    required int page,
    int limit = 10,
  }) async {
    final response = await apiService.get(
      ApiEndpoints.getPublishedTrips,
      queryParameters: {"page": page.toString(), "limit": limit.toString()},
    );

    final result = DriverTripsResponse.fromJson(response);

    final trips = result.data.trips;
    final meta = result.data.pagination;

    return (trips, meta);
  }

  Future<bool?> publishTrip({required TripPublishRequest publishedData}) async {
    _validateInputs(publishedData);

    final pickup = publishedData.pickupLatLng!;
    final dropoff = publishedData.dropoffLatLng!;

    return await safeCall<bool>(
      task: () async {
        await apiService.multipart(
          ApiEndpoints.createTrips,
          bodyFieldName: "POST",
          fields: {
            // pickup
            'pickupLocation[address]': publishedData.pickupAddress!.trim(),
            'pickupLocation[coordinates][0]': pickup.longitude.toString(),
            'pickupLocation[coordinates][1]': pickup.latitude.toString(),

            // dropoff
            'dropoffLocation[address]': publishedData.dropoffAddress!.trim(),
            'dropoffLocation[coordinates][0]': dropoff.longitude.toString(),
            'dropoffLocation[coordinates][1]': dropoff.latitude.toString(),

            // trip info
            'departureTime': publishedData.departureTime!
                .toUtc()
                .toIso8601String(),
            'pricePerSeat': publishedData.pricePerSeat!.toString(),
            'totalSeats': publishedData.totalSeats!.toString(),
            'vehicle': publishedData.vehicleId!,
            'routePolyline': publishedData.routePolyLine!,
            "description": publishedData.notes,
          },
          files: {
            'driverImage': [publishedData.driverImage!],
          },
        );
        return true;
      },
    );
  }

  Future<void> publishedTripDetailsById({
    required String id,
    PassengerTripDetailsResponse? tripDetails,
  }) async {
    await safeCall(
      task: () async {
        final res = await apiService.get(
          ApiEndpoints.publishedTripDetailsById(id),
        );
        final tempPublishedTrip = BookigsOfPublishedTripResponse.fromJson(res);
        final extra = state.extraState as TripsPublishState;
        state = state.copyWith(
          extraState: extra.copyWith(
            bookingsOfPublishedTrip: tempPublishedTrip,
            tripDetails: tripDetails,
          ),
        );
      },
    );
  }

  Future<void> genarateOtp({required String id}) async {
    await safeCall(
      task: () async {
        await apiService.patch(ApiEndpoints.generateDropOffOtp(id), {});
      },
    );
  }

  // -------------------------------
  // 🔎 Validation
  // -------------------------------
  void _validateInputs(TripPublishRequest data) {
    if (data.driverImage == null || !data.driverImage!.existsSync()) {
      throw Exception('Driver image is required');
    }

    if (_isEmpty(data.pickupAddress)) {
      throw Exception('Pickup address is required');
    }

    if (!_isValidLatLng(data.pickupLatLng)) {
      throw Exception('Invalid pickup location');
    }

    if (_isEmpty(data.dropoffAddress)) {
      throw Exception('Dropoff address is required');
    }

    if (!_isValidLatLng(data.dropoffLatLng)) {
      throw Exception('Invalid dropoff location');
    }

    if (data.departureTime == null) {
      throw Exception('Departure time must be in the future');
    }

    if (data.pricePerSeat == null || data.pricePerSeat! <= 0) {
      throw Exception('Price per seat must be greater than 0');
    }

    if (data.totalSeats == null || data.totalSeats! <= 0) {
      throw Exception('Total seats must be at least 1');
    }

    if (_isEmpty(data.vehicleId)) {
      throw Exception('Vehicle ID is required');
    }

    if (_isEmpty(data.routePolyLine)) {
      throw Exception('Route polyline is required');
    }
  }

  bool _isEmpty(String? value) => value == null || value.trim().isEmpty;

  bool _isValidLatLng(LatLng? latLng) {
    if (latLng == null) return false;
    return latLng.latitude >= -90 &&
        latLng.latitude <= 90 &&
        latLng.longitude >= -180 &&
        latLng.longitude <= 180;
  }
}
