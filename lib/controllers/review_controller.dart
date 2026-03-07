import 'package:velozaje/controllers/paginated_controller.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';
import 'package:velozaje/models/response/review_response.dart';
import 'package:velozaje/models/review_model.dart';

class ReviewState {
  final String driverId;

  ReviewState({required this.driverId});

  ReviewState copyWith({String? driverId, bool? loading}) {
    return ReviewState(driverId: driverId ?? this.driverId);
  }

  factory ReviewState.initial() {
    return ReviewState(driverId: '');
  }
}

class ReviewController extends PaginationNotifier<ReviewModel> {
  IApiService apiService;
  ReviewController({required this.apiService})
    : super(extraState: ReviewState.initial());

  Future<bool?> giveReview({
    required String bookingld,
    required String rating,
    required String review,
  }) async {
    return await safeCall<bool>(
      task: () async {
        final res = await apiService.post(ApiEndpoints.giveReview, {
          "bookingId": bookingld,
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

  Future<void> getAllReviewById({required String id}) async {
    state = state.copyWith(
      extraState: (state.extraState as ReviewState).copyWith(
        driverId: id,
        loading: true,
      ),
    );

    super.refresh();
    state = state.copyWith(
      extraState: (state.extraState as ReviewState).copyWith(loading: false),
    );
  }

  @override
  Future<(List<ReviewModel>, PaginationMetaModel)> fetchPage({
    required int page,
    required int limit,
  }) async {
    final res = await apiService.get(
      ApiEndpoints.getAllReviewById((state.extraState as ReviewState).driverId),
    );
    final response = DriverReviewsResponse.fromJson(res);
    return (response.data.reviews, response.data.pagination);
  }
}
