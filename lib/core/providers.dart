import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:velozaje/controllers/conversation_controller.dart';
import 'package:velozaje/controllers/report_controller.dart';
import 'package:velozaje/controllers/review_controller.dart';
import 'package:velozaje/controllers/trip/trips_publish_controller.dart';
import 'package:velozaje/controllers/paginated_controller.dart';
import 'package:velozaje/controllers/trip/trips_book_controller.dart';
import 'package:velozaje/controllers/wallet_and_payment_controller.dart';
import 'package:velozaje/core/services/localstorage/i_local_storage_service.dart';
import 'package:velozaje/controllers/auth_controller.dart';
import 'package:velozaje/controllers/saved_location_controller.dart';
import 'package:velozaje/controllers/trip/trips_search_controller.dart';
import 'package:velozaje/core/services/localstorage/storage_key.dart';
import 'package:velozaje/core/services/socket/socket_config.dart';
import 'package:velozaje/core/services/socket/socket_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/response/chat/messages_for_a_spacific_conversation_response.dart';
import 'package:velozaje/models/response/trip/booking_response.dart';
import 'package:velozaje/models/response/trip/driver_published_trips.dart';
import 'package:velozaje/models/response/trip/passenger_trip_model.dart';
import 'package:velozaje/controllers/vehicale_register_controller.dart';
import 'package:velozaje/feature/notifications/notification_model.dart';
import 'package:velozaje/feature/notifications/notifications_controller.dart';
import 'package:velozaje/models/response/wallet_response.dart';
import 'package:velozaje/models/review_model.dart';
import 'services/api/api_client.dart';
import 'services/api/api_service.dart';
import 'services/localstorage/local_storage_service.dart';
import 'services/api/i_api_service.dart';

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

final socketServiceProvider = FutureProvider<SocketService>((ref) async {
  final socketService = SocketService();
  final storage = ref.read(localStorageProvider);
  final token = await storage.getString(StorageKey.accessToken) ?? "";
  socketService.init(SocketConfig(url: ApiEndpoints.baseUrl, token: token));
  return socketService;
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
    StateNotifierProvider<
      WalletAndPaymentController,
      PaginationState<EarningModel>
    >((ref) {
      final apiService = ref.read(apiServiceProvider);
      return WalletAndPaymentController(apiService: apiService);
    });

final conversationControllerProvider =
    StateNotifierProvider<ConversationController, PaginationState<Message>>((
      ref,
    ) {
      final apiService = ref.read(apiServiceProvider);
      return ConversationController(apiService);
    });
final reviewControllerProvider =
    StateNotifierProvider<ReviewController, PaginationState<ReviewModel>>((
      ref,
    ) {
      final apiService = ref.read(apiServiceProvider);
      return ReviewController(apiService: apiService);
    });
final reportControllerProvider =
    StateNotifierProvider<ReportController, ReportState>((ref) {
      final apiService = ref.read(apiServiceProvider);
      return ReportController(apiService);
    });
