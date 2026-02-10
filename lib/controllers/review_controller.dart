import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';

class ReviewController extends BaseNotifier {
  IApiService apiService;
  ReviewController({required this.apiService}) : super(null);

  Future<bool?> giveReview({
    required String bookingld,
    required String rating,
    required String review,
  }) async {
    return await safeCall<bool>(
      task: () async {
        final res = await apiService.post(ApiEndpoints.giveReview, {
          "bookingld": bookingld,
          "rating": rating,
          "review": review,
        });
        if (res['sucess'] == true) {
          return true;
        }
        return false;
      },
    );
  }
}
