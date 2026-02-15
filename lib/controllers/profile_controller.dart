import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/legacy.dart';
import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/models/user_model.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/services/localstorage/i_local_storage_service.dart';
import 'package:velozaje/core/services/providers.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/response/profile_response/profile_response.dart';

final StateNotifierProvider<ProfileController, ProfileState>
profileControllerProvider =
    StateNotifierProvider<ProfileController, ProfileState>((ref) {
      final apiService = ref.read(apiServiceProvider);
      final localStorageService = ref.read(localStorageProvider);

      return ProfileController(
        apiService: apiService,
        localStorageService: localStorageService,
      );
    });

class ProfileState {
  final UserModel? user;

  const ProfileState({this.user});

  ProfileState copyWith({UserModel? user}) {
    return ProfileState(user: user ?? this.user);
  }
}

class ProfileController extends BaseNotifier<ProfileState> {
  final IApiService apiService;
  final ILocalStorageService localStorageService;
  ProfileController({
    required this.apiService,
    required this.localStorageService,
  }) : super(ProfileState());

  Future<void> getProfile() async {
    safeCall(
      task: () async {
        final response = await apiService.get(ApiEndpoints.profile);

        if (response['success'] ?? false) {
          final user = UserProfileResponse.fromJson(response);
          state = state.copyWith(user: user.data);
        } else {
          throw Exception(response['message'] ?? 'Profile fatch faield');
        }
      },
    );
  }

  Future<bool?> updateProfile({
    String? phone,
    String? address,
    String? dateOfBirth,
    File? image,
  }) async {
    return await safeCall<bool>(
      task: () async {
        log("${image?.path}");
        final response = await apiService.multipart(
          ApiEndpoints.profile,
          method: "PATCH",
          files: (image != null)
              ? {
                  "image": [image],
                }
              : null,
          fields: {
            if (address != null) "address": address,
            if (dateOfBirth != null) "dateOfBirth": dateOfBirth,
            if (phone != null) "phone": phone,
          },
        );

        if (response['success'] ?? false) {
          final user = UserProfileResponse.fromJson(response);
          state = state.copyWith(user: user.data);
          return true;
        } else {
          throw Exception(response['message'] ?? 'Profile fatch faield');
        }
      },
    );
  }
}
