import 'dart:developer';
import 'dart:io';

import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/services/localstorage/i_local_storage_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/response/vehicale_response/my_vehicale_response.dart';
import 'package:velozaje/models/vehicale_model.dart';
import 'package:velozaje/models/response/vehicale_response/vehicale_resistration_response.dart';


class VehicaleState {
  final Vehicle? vehicale;

  const VehicaleState({this.vehicale});

  VehicaleState copyWith({Vehicle? vehicale}) {
    return VehicaleState(vehicale: vehicale ?? this.vehicale);
  }
}

class VehicaleController extends BaseNotifier<VehicaleState> {
  final IApiService apiService;
  final ILocalStorageService localStorageService;
  VehicaleController({
    required this.apiService,
    required this.localStorageService,
  }) : super(VehicaleState());

  Future<void> getMyVehicale() async {
    safeCall(
      task: () async {
        final response = await apiService.get(ApiEndpoints.myVehicle);

        if (response['success'] ?? false) {
          final user = MyVehicleResponse.fromJson(response);
          state = state.copyWith(vehicale: user.data);
        } else {
          throw Exception(response['message'] ?? 'Vehicale fatch failed');
        }
      },
    );
  }

  Future<bool?> registerVehicale({
    required String vehicleType,
    required String registration,
    required String year,
    required String brand,
    required String vehicleModel,
    required String licensePlateNumber,
    File? image,
  }) async {
    return await safeCall<bool>(
      task: () async {
        log(vehicleType);
        final response = await apiService.multipart(
          ApiEndpoints.registerVehicale,
          method: "post",
          files: image != null
              ? {
                  "images": [image],
                }
              : null,
          fields: {
            "vehicleType": vehicleType,
            "registration": registration,
            "year": year,
            "brand": brand,
            "vehicleModel": vehicleModel,
            "licensePlateNumber": licensePlateNumber,
          },
        );

        if (response['success'] == true) {
          final vehicleResponse = VehicleResponse.fromJson(response);
          state = state.copyWith(vehicale: vehicleResponse.data);
          return true;
        } else {
          throw Exception(response['message'] ?? 'Vehicle submission failed');
        }
      },
    );
  }
}
