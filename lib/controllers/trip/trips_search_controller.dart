import 'dart:developer';

import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';
import 'package:velozaje/controllers/paginated_controller.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/request/trip_search_request.dart';
import 'package:velozaje/models/response/trip/passenger_trip_details_response.dart';
import 'package:velozaje/models/response/trip/passenger_trip_model.dart';
import 'package:velozaje/models/response/trip/passenger_trips_response.dart';

class TripsSearchController extends PaginationNotifier<PassengerTripModel> {
  final IApiService apiService;

  PassengerTripDetailsResponse? tripDetails;

  TripsSearchController(this.apiService);
  static TripSearchRequest? request;

  @override
  Future<(List<PassengerTripModel>, PaginationMetaModel)> fetchPage({
    required int page,
    int limit = 10,
  }) async {
    log(
      "=========>>>>>>>>>>>>" + request!.departureTime.toIso8601String() + "Z",
    );
    final response = await apiService.get(
      ApiEndpoints.passengerTrips,
      queryParameters: {
        "page": page.toString(),
        "limit": limit.toString(),

        // if (pickupLat != null) "pickupLat": pickupLat.toString(),
        // if (pickupLng != null) "pickupLng": pickupLng.toString(),
        // if (dropoffLat != null) "dropoffLat": dropoffLat.toString(),
        // if (dropoffLng != null) "dropoffLng": dropoffLng.toString(),
        // if (minSeats != null) "minSeats": minSeats.toString(),
        // if (sort != null) "sort": sort.toString(),
        // if (order != null) "order": order.toString(),
        // if (tripType != null) "tripType": tripType.toString(),
        if (request?.pickupLatLng != null)
          "pickupLat": request!.pickupLatLng!.latitude.toString(),
        if (request?.pickupLatLng != null)
          "pickupLng": request!.pickupLatLng!.longitude.toString(),

        if (request?.destinationLatLng != null)
          "dropoffLat": request!.destinationLatLng!.latitude.toString(),
        if (request?.destinationLatLng != null)
          "dropoffLng": request!.destinationLatLng!.longitude.toString(),

        "tripType": request?.bookingType.name ?? BookingType.travel.name,

        if (request != null) "minSeats": request!.passengersCount.toString(),

        if (request != null)
          "date-temp": "${request!.departureTime.toIso8601String()}Z",
      },
    );

    final result = PassengerTripsResponse.fromJson(response);

    final trips = result.data.data.trips;
    final meta = result.data.data.pagination;

    return (trips, meta);
  }

  Future<PassengerTripDetailsResponse?> getTripDetails({
    required String tripId,
  }) async {
    return await safeCall<PassengerTripDetailsResponse>(
      task: () async {
        final response = await apiService.get(
          ApiEndpoints.passengerTripDetails(tripId),
          queryParameters: {"includePassengers": "true"},
        );

        final result = PassengerTripDetailsResponse.fromJson(response);
        tripDetails = result;
        return result;
      },
    );
  }
}
