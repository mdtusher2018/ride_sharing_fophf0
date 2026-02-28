import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:velozaje/controllers/paginated_controller.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';
import 'package:velozaje/models/response/wallet_response.dart';

class WalletAndPaymentController extends PaginationNotifier<EarningModel> {
  final IApiService apiService;
  WalletAndPaymentController({required this.apiService});

  double totalEarnings = 0;
  double completedPayments = 0;

  @override
  Future<void> refresh({Function(int, String)? handleErrorExplecitly}) {
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

    return (driverEarningModel.earnings, driverEarningModel.pagination);
  }

  Future<void> payCommission({
    required num amount,
    required String description,
    required VoidCallback midCallFunction,
  }) async {
    safeCall(
      task: () async {
        final response = await apiService.post(ApiEndpoints.payCommission, {
          "amount": amount,
          "description": description,
        });
        final clientSecret = response['data']['clientSecret'] as String;

        midCallFunction();

        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            style: ThemeMode.light,
            merchantDisplayName: "Terru",
          ),
        );

        // 3. Present Payment Sheet
        await Stripe.instance.presentPaymentSheet();
      },
    );
  }
}
