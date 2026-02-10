class PaginationMetaModel {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  PaginationMetaModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory PaginationMetaModel.fromJson(Map<String, dynamic> json) {
    return PaginationMetaModel(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 0,
    );
  }
}
