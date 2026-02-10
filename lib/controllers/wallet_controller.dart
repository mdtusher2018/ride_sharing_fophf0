import 'package:velozaje/controllers/paginated_controller.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';
import 'package:velozaje/models/response/wallet_response.dart';

class WalletController extends PaginationNotifier<EarningModel> {
  final IApiService apiService;
   WalletController({required this.apiService});

  double totalEarnings = 0;
  double completedPayments = 0;

  @override
  Future<void> refresh() {
    _fetchSummary();
    return super.refresh();
  }

  Future<void> _fetchSummary() async {
    safeCall(
      task: () async {
        final response = await apiService.get(
          ApiEndpoints.driverTransactionsSummary,
        );
        final responseModel = DriverEarningsSummary.fromJson(response);
        totalEarnings = responseModel.totalEarnings;
        completedPayments = responseModel.completedPayments;
      },
    );
  }

  @override
  Future<(List<EarningModel>, PaginationMetaModel)> fetchPage({
    required int page,
    required int limit,
  }) async {
    final response = await apiService.get(ApiEndpoints.driverTransactions);

    final driverEarningModel = DriverEarningsResponse.fromJson(response);

    return (
      driverEarningModel.data.earnings,
      driverEarningModel.data.pagination,
    );
  }
}
