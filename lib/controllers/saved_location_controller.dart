import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/response/add_save_place_response.dart';
import 'package:velozaje/models/response/saved_place_response.dart';
import 'package:velozaje/models/save_location_model.dart';

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

  Future<void> saveLocation({
    required String address,
    required String placeName,
    required LatLng? latlng, // make non-nullable
    required Function(bool) onSucess,
  }) async {
    await safeCall(
      task: () async {
        if (address.trim().isEmpty) {
          throw Exception("Address cannot be empty");
        }
        if (latlng == null) {
          throw Exception("Address not found");
        }
        final String finalPlaceName = placeName.trim().isEmpty
            ? address
            : placeName;

        final response = await apiService.post(ApiEndpoints.saveLocation, {
          "placeName": finalPlaceName,
          "address": address,
          "coordinates": [latlng.longitude, latlng.latitude],
        });

        final savedPlacesResponse = AddSavedLocationResponse.fromJson(response);

        state = state.copyWith(
          savedPlaces: [...state.savedPlaces, savedPlacesResponse.data],
        );
        onSucess(true);
      },
    );
  }

  Future<void> removeSaveLocation({required String id}) async {
    await safeCall(
      task: () async {
        final response = await apiService.delete(
          ApiEndpoints.removeSaveLocation(id),
        );

        if (response['success'] ?? false) {
          state = state.copyWith(
            savedPlaces: state.savedPlaces
                .where((place) => place.id != id)
                .toList(),
          );
        }
      },
    );
  }
}
