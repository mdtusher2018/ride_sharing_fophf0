import 'package:velozaje/models/pagenation_meta_model.dart';
import 'package:velozaje/controllers/paginated_controller.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/response/trip/passenger_trip_details_response.dart';
import 'package:velozaje/models/response/trip/passenger_trip_model.dart';
import 'package:velozaje/models/response/trip/passenger_trips_response.dart';

class TripsSearchController extends PaginationNotifier<PassengerTripModel> {
  final IApiService apiService;

  PassengerTripDetailsResponse? tripDetails;

  TripsSearchController(this.apiService);

  @override
  Future<(List<PassengerTripModel>, PaginationMetaModel)> fetchPage({
    required int page,
    int limit = 10,
    double? pickupLat,
    double? pickupLng,
    double? dropoffLat,
    double? dropoffLng,
    int? minSeats,
    String? sort,
    String? order,
    String? tripType, // Optional: you can add other parameters here
  }) async {
    final response = await apiService.get(
      ApiEndpoints.passengerTrips,
      queryParameters: {
        "page": page.toString(),
        "limit": limit.toString(),
        if (pickupLat != null) "pickupLat": pickupLat.toString(),
        if (pickupLng != null) "pickupLng": pickupLng.toString(),
        if (dropoffLat != null) "dropoffLat": dropoffLat.toString(),
        if (dropoffLng != null) "dropoffLng": dropoffLng.toString(),
        if (minSeats != null) "minSeats": minSeats.toString(),
        if (sort != null) "sort": sort,
        if (order != null) "order": order,
        if (tripType != null) "tripType": tripType,
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
