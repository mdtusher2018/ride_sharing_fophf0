import 'package:velozaje/core/utils/api_data_praser_helper.dart';
import 'package:velozaje/models/conversation_model.dart';

class AllConversationResponse {
  final bool success;
  final String message;
  final List<ConversationModel> data;

  AllConversationResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AllConversationResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AllConversationResponse.empty();
    }

    return AllConversationResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: JsonHelper.safeList(
        json['data'],
        (e) => ConversationModel.fromJson(e),
      ),
    );
  }

  factory AllConversationResponse.empty() =>
      AllConversationResponse(success: false, message: '', data: []);
}
