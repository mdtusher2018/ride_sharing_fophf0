class TripReportFromOthersUserResponse {
  final bool success;
  final String message;
  final List<TripReport> reports;
  final int count;

  TripReportFromOthersUserResponse({
    required this.success,
    required this.message,
    required this.reports,
    required this.count,
  });

  factory TripReportFromOthersUserResponse.fromJson(Map<String, dynamic> json) {
    return TripReportFromOthersUserResponse(
      success: json['success'],
      message: json['message'],
      reports: List<TripReport>.from(
        json['data']['reports'].map((x) => TripReport.fromJson(x)),
      ),
      count: json['data']['count'],
    );
  }
}

class TripReport {
  final String id;
  final String reporterName;
  final String reporterImage;
  final String reportedUserName;
  final String reportedUserImage;
  final String booking;
  final String trip;
  final String reportSubjectTitle;
  final String reason;
  final String additionalDetails;
  final String status;
  final int verificationCount;
  final bool hasVerified;
  final DateTime createdAt;

  TripReport({
    required this.id,
    required this.reporterName,
    required this.reporterImage,
    required this.reportedUserName,
    required this.reportedUserImage,
    required this.booking,
    required this.trip,
    required this.reportSubjectTitle,
    required this.reason,
    required this.additionalDetails,
    required this.status,
    required this.verificationCount,
    required this.hasVerified,
    required this.createdAt,
  });

  factory TripReport.fromJson(Map<String, dynamic> json) {
    return TripReport(
      id: json['_id'],
      reporterName: json['reporter']?['fullName'] ?? "",
      reporterImage: json['reporter']?['image'] ?? "",
      reportedUserName: json['reportedUser']?['fullName'] ?? "",
      reportedUserImage: json['reportedUser']?['image'] ?? "",
      booking: json['booking'] ?? "",
      trip: json['trip'] ?? "",
      reportSubjectTitle: json['reportSubject']?['title'] ?? "",
      reason: json['reason'] ?? "",
      additionalDetails: json['additionalDetails'] ?? "",
      status: json['status'] ?? "",
      verificationCount: json['verificationCount'] ?? 0,
      hasVerified: json['hasVerified'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
