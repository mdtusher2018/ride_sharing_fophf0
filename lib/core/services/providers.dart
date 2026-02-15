import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:velozaje/controllers/trip/trips_publish_controller.dart';
import 'package:velozaje/controllers/paginated_controller.dart';
import 'package:velozaje/controllers/trip/trips_book_controller.dart';
import 'package:velozaje/controllers/wallet_controller.dart';
import 'package:velozaje/core/services/localstorage/i_local_storage_service.dart';
import 'package:velozaje/controllers/auth_controller.dart';
import 'package:velozaje/controllers/saved_location_controller.dart';
import 'package:velozaje/controllers/trip/trips_search_controller.dart';
import 'package:velozaje/models/response/trip/booking_response.dart';
import 'package:velozaje/models/response/trip/driver_published_trips.dart';
import 'package:velozaje/models/response/trip/passenger_trip_model.dart';
import 'package:velozaje/controllers/vehicale_register_controller.dart';
import 'package:velozaje/feature/notifications/notification_model.dart';
import 'package:velozaje/feature/notifications/notifications_controller.dart';
import 'package:velozaje/models/response/wallet_response.dart';
import 'api/api_client.dart';
import 'api/api_service.dart';
import 'localstorage/local_storage_service.dart';
import 'api/i_api_service.dart';

/////////////////
///    Core   ///
/////////////////

final Provider<ILocalStorageService> localStorageProvider =
    Provider<ILocalStorageService>((ref) {
      LocalStorageService.init();
      return LocalStorageService();
    });

final Provider<ApiClient> apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final Provider<IApiService> apiServiceProvider = Provider<IApiService>((ref) {
  final client = ref.read(apiClientProvider);
  final storage = ref.read(localStorageProvider);
  return ApiService(client, storage);
});

/////////////////
///    Auth   ///
/////////////////

final authControllerProvider = Provider<AuthController>((ref) {
  final IApiService apiService = ref.read(apiServiceProvider);
  final ILocalStorageService localStorageService = ref.read(
    localStorageProvider,
  );
  return AuthController(
    apiService: apiService,
    localStorageService: localStorageService,
  );
});

final savedLocationProvider =
    StateNotifierProvider<SavedLocationController, SavedLocationState>(
      (ref) =>
          SavedLocationController(apiService: ref.read(apiServiceProvider)),
    );

final passengerTripsControllerProvider =
    StateNotifierProvider<
      TripsSearchController,
      PaginationState<PassengerTripModel>
    >((ref) {
      final apiService = ref.watch(apiServiceProvider);
      return TripsSearchController(apiService);
    });

final tripsBookingControllerProvider =
    StateNotifierProvider<
      TrippBookController,
      PaginationState<PassengerBookingModel>
    >((ref) {
      final apiService = ref.watch(apiServiceProvider);
      return TrippBookController(apiService);
    });

final tripsPublishControllerProvider =
    StateNotifierProvider<
      TripsPublishController,
      PaginationState<DriverTripModel>
    >((ref) {
      final apiService = ref.watch(apiServiceProvider);
      return TripsPublishController(apiService);
    });

final StateNotifierProvider<VehicaleController, VehicaleState>
vehicaleControllerProvider =
    StateNotifierProvider<VehicaleController, VehicaleState>((ref) {
      final apiService = ref.read(apiServiceProvider);
      final localStorageService = ref.read(localStorageProvider);

      return VehicaleController(
        apiService: apiService,
        localStorageService: localStorageService,
      );
    });

final notificationsControllerProvider =
    StateNotifierProvider<
      NotificationController,
      PaginationState<NotificationItem>
    >((ref) {
      final apiService = ref.read(apiServiceProvider);
      return NotificationController(apiService);
    });

final walletControllerProvider =
    StateNotifierProvider<WalletController, PaginationState<EarningModel>>((
      ref,
    ) {
      final apiService = ref.read(apiServiceProvider);
      return WalletController(apiService: apiService);
    });
