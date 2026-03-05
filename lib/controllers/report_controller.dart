import 'package:flutter/scheduler.dart';
import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/response/report_subject_response.dart';

class ReportState {
  final List<ReportSubject> data;
  final bool canIReport;
  final bool isLoading;
  final String? error;

  ReportState({
    required this.data,
    this.isLoading = false,
    this.error,
    this.canIReport = false,
  });

  ReportState copyWith({
    List<ReportSubject>? data,
    bool? isLoading,
    String? error,
    bool? canIReport,
  }) {
    return ReportState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      canIReport: this.canIReport,
      error: error ?? this.error,
    );
  }
}

class ReportController extends BaseNotifier<ReportState> {
  final IApiService _apiService;

  ReportController(this._apiService)
    : super(ReportState(data: [], isLoading: false));

  Future<void> fetchReportSubjects() async {
    safeCall(
      task: () async {
        final response = await _apiService.get(ApiEndpoints.reportSubjects);

        final model = ReportSubjectsResponse.fromJson(response);

        state = state.copyWith(data: model.data);
      },
    );
  }

  Future<void> canIReport({required String tripId}) async {
    safeCall(
      task: () async {
        final response = await _apiService.get(
          ApiEndpoints.reportOfSpacificDriverByTrip(tripId),
        );
        bool caniReport = response['success'] ?? false;

        state = state.copyWith(canIReport: caniReport);
      },
    );
  }

  Future<void> submitAReport({
    required String reportedUserId,
    required String reportSubjectId,
    String? additionalDetails,
    required VoidCallback onCompleate,
  }) async {
    await safeCall(
      task: () async {
        final response = await _apiService.post(ApiEndpoints.submitAReport, {
          'reportedUserId': reportedUserId,
          'reportSubjectId': reportSubjectId,
          'additionalDetails': additionalDetails,
        });
        final bool success = response['success'] ?? false;
        final String message = response['message'] ?? 'UnKnown Error occoured';

        if (!success) {
          throw Exception(message);
        }
      },
      onStart: () {
        state = state.copyWith(isLoading: true);
      },
      onComplete: () {
        onCompleate();
        state = state.copyWith(isLoading: false);
      },
      showSuccessSnack: true,
      showLoading: false,
      successMessage: "Report Submited Sucessfully",
    );
  }
}
