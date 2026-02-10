import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/response/saved_place_response.dart';

class SavedLocationState {
  final List<SavedLocation> savedPlaces;

  SavedLocationState({this.savedPlaces = const []});

  SavedLocationState copyWith({List<SavedLocation>? savedPlaces}) {
    return SavedLocationState(savedPlaces: savedPlaces ?? this.savedPlaces);
  }
}

class SavedLocationController extends BaseNotifier<SavedLocationState> {
  final IApiService apiService;

  SavedLocationController({required this.apiService})
    : super(SavedLocationState());

  Future<void> getSavedLocations() async {
    safeCall(
      task: () async {
        final response = await apiService.get(ApiEndpoints.mySavedLocations);

        final savedPlacesResponse = SavedLocationsResponse.fromJson(response);

        state = state.copyWith(
          savedPlaces: savedPlacesResponse.data.savedPlaces,
        );
      },
    );
  }
}
