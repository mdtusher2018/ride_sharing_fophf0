import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class PaginationMetaModel {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  const PaginationMetaModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  /// 🔹 Normal JSON constructor (safe)
  factory PaginationMetaModel.fromJson(Map<String, dynamic> json) {
    return PaginationMetaModel(
      page: JsonHelper.intVal(json['page'], fallback: 1),
      limit: JsonHelper.intVal(json['limit'], fallback: 10),
      total: JsonHelper.intVal(json['total']),
      totalPage: JsonHelper.intVal(json['totalPages']),
    );
  }

  /// 🔹 Empty constructor
  factory PaginationMetaModel.empty() {
    return const PaginationMetaModel(
      page: 1,
      limit: 10,
      total: 0,
      totalPage: 0,
    );
  }
}
