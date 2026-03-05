import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/core/utils/extention.dart';

import 'package:velozaje/models/response/report_subject_response.dart';
import 'package:velozaje/models/response/reports_from_others_user_response.dart';

class ReportState {
  final List<ReportSubject> data;
  final List<TripReport> reportsFromOthersUser;
  final bool canIReport;
  final int reportCount;
  final bool isLoading;
  final String? error;

  ReportState({
    required this.data,
    this.isLoading = false,
    this.reportCount = 0,
    this.error,
    this.canIReport = false,
    this.reportsFromOthersUser = const [],
  });

  ReportState copyWith({
    List<ReportSubject>? data,
    bool? isLoading,
    int? reportCount,
    String? error,
    bool? canIReport,
    List<TripReport>? reportsFromOthersUser,
  }) {
    return ReportState(
      data: data ?? this.data,
      reportCount: reportCount ?? this.reportCount,
      isLoading: isLoading ?? this.isLoading,
      canIReport: canIReport ?? this.canIReport,
      error: error ?? this.error,
      reportsFromOthersUser:
          reportsFromOthersUser ?? this.reportsFromOthersUser,
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
          queryParameters: {"onlyCount": "true"},
        );
        bool caniReport = response['success'] ?? false;
        int count = response['data']?['count'] ?? 0;
        state = state.copyWith(canIReport: caniReport, reportCount: count);
      },
    );
  }

  Future<void> reportsFromOthersUser({required String tripId}) async {
    safeCall(
      task: () async {
        final response = await _apiService.get(
          ApiEndpoints.reportOfSpacificDriverByTrip(tripId),
        );
        final result = TripReportFromOthersUserResponse.fromJson(response);
        state = state.copyWith(reportsFromOthersUser: result.reports);
      },
    );
  }

  Future<void> verifyAReport({
    required String reportId,
    required BuildContext context,
  }) async {
    safeCall(
      task: () async {
        final response = await _apiService.post(
          ApiEndpoints.reportVerification(reportId),
          {},
        );
        if (response['success'] ?? false) {
          context.showCommonSnackbar(
            title: "Sucess",
            message: "Report Verified Sucessfully",
          );
        }
      },
    );
  }

  Future<void> unverifyAReport({
    required String reportId,
    required BuildContext context,
  }) async {
    safeCall(
      task: () async {
        final response = await _apiService.delete(
          ApiEndpoints.reportVerification(reportId),
        );
        if (response['success'] ?? false) {
          context.showCommonSnackbar(
            title: "Sucess",
            message: "Report UnVerified Sucessfully",
          );
        }
      },
    );
  }

  Future<void> submitAReport({
    required String reportedUserId,
    required String reportSubjectId,
    required String bookingId,
    String? additionalDetails,
    required VoidCallback onCompleate,
  }) async {
    await safeCall(
      task: () async {
        if (bookingId.isEmpty) {
          throw Exception(
            "You’re unable to report this driver because no trip was taken with him.",
          );
        }

        final response = await _apiService.post(ApiEndpoints.submitAReport, {
          'reportedUserId': reportedUserId,
          'reportSubjectId': reportSubjectId,
          'additionalDetails': additionalDetails,
          'bookingId': bookingId,
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
