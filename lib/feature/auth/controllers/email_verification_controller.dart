// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:velozaje/core/base_notifier.dart';
// import 'package:velozaje/core/services/api/i_api_service.dart';
// import 'package:velozaje/core/services/localstorage/i_local_storage_service.dart';
// import 'package:velozaje/core/services/localstorage/storage_key.dart';
// import 'package:velozaje/core/services/providers.dart';
// import 'package:velozaje/core/utils/api_end_points.dart';
// import 'package:velozaje/core/utils/extention.dart';
// import 'package:velozaje/core/utils/global_keys.dart';
// import 'package:velozaje/feature/auth/models/email_verification_model.dart';
// import 'package:velozaje/feature/auth/view/confirm_details_view.dart';

// final emailVerificationProvider = Provider((ref) {
//   return EmailVerificationController(
//     apiService: ref.read(apiServiceProvider),
//     localStorageService: ref.read(localStorageProvider),
//   );
// });

// class EmailVerificationController extends BaseNotifier {
//   final IApiService apiService;
//   final ILocalStorageService localStorageService;

//   EmailVerificationController({
//     required this.apiService,
//     required this.localStorageService,
//   }) : super(false);

//   Future<void> emailVerification({
//     required String email,
//     required String otp,
//   }) async {
//     safeCall(
//       task: () async {
//         final response = await apiService.post(ApiEndpoints.verifyOTP, {
//           "email": email,
//           "otp": otp,
//           "purpose": "emailVerify",
//         });
//         if (response['success'] ?? false) {
//           final user = EmailVerificationModel.fromJson(response);

//           await localStorageService.saveString(
//             StorageKey.accessToken,
//             user.token,
//           );

//           navigatorKey.currentContext?.navigateTo(ConfirmDetailsPage());
//         } else {
//           throw Exception(response['message'] ?? 'Failed to send OTP failed');
//         }
//       },
//     );
//   }
// }
