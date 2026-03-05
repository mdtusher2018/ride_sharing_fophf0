import 'package:velozaje/core/utils/api_data_praser_helper.dart';

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
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: JsonHelper.safeList<ReportSubject>(
        json['data'],
        (e) => ReportSubject.fromJson(e),
      ),
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
      id: JsonHelper.stringVal(json['_id']),
      title: JsonHelper.stringVal(json['title']),
      isActive: JsonHelper.boolVal(json['isActive']),
      createdAt: JsonHelper.parseDate(json['createdAt']),
      updatedAt: JsonHelper.parseDate(json['updatedAt']),
    );
  }
}
