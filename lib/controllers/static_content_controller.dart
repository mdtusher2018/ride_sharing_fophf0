import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';

class StaticContentState {
  final String termsAndCondition;
  final String email;
  final String facebook;
  final String instagram; // Fix the typo 'INSTREAGRAM' to 'instagram'
  final String phone;

  // Default constructor for setting the state with actual values
  StaticContentState({
    this.termsAndCondition = "",
    this.email = "",
    this.facebook = "",
    this.instagram = "",
    this.phone = "",
  });

  // Adding copyWith method to allow updates to the state
  StaticContentState copyWith({
    String? termsAndCondition,
    String? email,
    String? facebook,
    String? instagram,
    String? phone,
  }) {
    return StaticContentState(
      termsAndCondition: termsAndCondition ?? this.termsAndCondition,
      email: email ?? this.email,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      phone: phone ?? this.phone,
    );
  }
}

class StaticContentController extends BaseNotifier<StaticContentState> {
  final IApiService apiService;

  StaticContentController({required this.apiService})
    : super(StaticContentState());

  Future<void> getTermsAndConditions() async {
    safeCall(
      task: () async {
        final response = await apiService.get(
          ApiEndpoints.getTermsAndCondition,
        );
        if (response['success'] ?? false) {
          final terms =
              ((response['data']['terms'] as List?)?.isNotEmpty ?? false)
              ? (response['data']['terms'] as List).first['content'] ?? ''
              : '';
          state = state.copyWith(termsAndCondition: terms);
        } else {
          throw Exception(
            response['message'] ?? 'Failed to fetch terms and conditions',
          );
        }
      },
    );
  }

  Future<void> getContact() async {
    safeCall(
      task: () async {
        final response = await apiService.get(ApiEndpoints.getContact);
        if (response['success'] ?? false) {
          final contactData = response['data'] ?? {};
          state = state.copyWith(
            email: contactData['email'] ?? '',
            facebook: contactData['facebook'] ?? '',
            instagram: contactData['instagram'] ?? '',
            phone: contactData['phone'] ?? '',
          );
        } else {
          throw Exception(
            response['message'] ?? 'Failed to fetch contact information',
          );
        }
      },
    );
  }
}
