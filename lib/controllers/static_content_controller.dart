import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/response/get_contact_response.dart';

class StaticContentState {
  final String termsAndCondition;
  final List<ContactPlatform> contactPlatfroms;

  // Default constructor for setting the state with actual values
  StaticContentState({
    this.termsAndCondition = "",
    this.contactPlatfroms = const [],
  });

  // Adding copyWith method to allow updates to the state
  StaticContentState copyWith({
    String? termsAndCondition,
    List<ContactPlatform>? contactPlatfroms,
  }) {
    return StaticContentState(
      termsAndCondition: termsAndCondition ?? this.termsAndCondition,
      contactPlatfroms: contactPlatfroms ?? this.contactPlatfroms,
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
        final result = GetContactResponse.fromJson(response);
        if (result.success) {
          state = state.copyWith(contactPlatfroms: result.data.platforms);
        } else {
          throw Exception(
            response['message'] ?? 'Failed to fetch contact information',
          );
        }
      },
    );
  }
}
