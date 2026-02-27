import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class UnreadMessageCountResponse {
  final bool success;
  final String message;
  final int count;

  UnreadMessageCountResponse({
    required this.success,
    required this.message,
    required this.count,
  });

  factory UnreadMessageCountResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return UnreadMessageCountResponse.empty();
    }

    final dataJson = json['data'];
    final countValue = (dataJson is Map<String, dynamic>)
        ? JsonHelper.intVal(dataJson['count'])
        : 0;

    return UnreadMessageCountResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      count: countValue,
    );
  }

  factory UnreadMessageCountResponse.empty() =>
      UnreadMessageCountResponse(success: false, message: '', count: 0);
}
