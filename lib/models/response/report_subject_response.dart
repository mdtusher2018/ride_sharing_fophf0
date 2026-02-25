class ReportSubjectsResponse {
  final bool success;
  final String message;
  final List<ReportSubject> data;

  ReportSubjectsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ReportSubjectsResponse.fromJson(Map<String, dynamic> json) {
    return ReportSubjectsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => ReportSubject.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ReportSubject {
  final String id;
  final String title;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReportSubject({
    required this.id,
    required this.title,
    required this.isActive,

    required this.createdAt,
    required this.updatedAt,
  });

  factory ReportSubject.fromJson(Map<String, dynamic> json) {
    return ReportSubject(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      isActive: json['isActive'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
