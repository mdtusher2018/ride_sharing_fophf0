import 'dart:io';

import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';
import 'package:velozaje/controllers/paginated_controller.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/request/trip_search_request.dart';
import 'package:velozaje/models/response/trip/booking_details_response.dart';
import 'package:velozaje/models/response/trip/booking_response.dart';
import 'package:velozaje/models/response/trip/passenger_trip_model.dart';

class PassangerTripBookingController
    extends PaginationNotifier<PassengerBookingModel> {
  final IApiService apiService;

  PassangerTripBookingController(this.apiService);

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

  Future<bool?> bookTrip({
    required PassengerTripModel tripDetails,
    required TripSearchRequest tripSearched,
    required File passengerImage,
  }) async {
    // Build multipart fields map from inputs
    final Map<String, String> fields = {
      'trip': tripDetails.id,
      'seatsBooked': tripSearched.passengersCount.toString(),
      'bookingType':
          tripSearched.bookingType.name, // Assuming enum extension .name

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
      final package = tripSearched.packages.first;

      fields.addAll({
        'packageDetails[weight]': package.weightKg.toString(),
        'packageDetails[quantity]': tripSearched.packages.length.toString(),
        'packageDetails[dimensions][length]': package.lengthCm.toString(),
        'packageDetails[dimensions][width]': package.widthCm.toString(),
        'packageDetails[dimensions][height]': package.heightCm.toString(),
      });
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

  Future<void> bookingDetailsById({required String id}) async {
    safeCall(
      task: () async {
        final res = await apiService.get(
          ApiEndpoints.passengerBookedTripDetailsById(id),
        );
        bookingDetail = PassengerBookedDetailsResponse.fromJson(res).booking;
      },
    );
  }
}
