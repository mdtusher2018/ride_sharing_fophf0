import 'package:velozaje/core/utils/api_data_praser_helper.dart';
import 'package:velozaje/models/response/chat/messages_for_a_spacific_conversation_response.dart';

class SendMessageResponse {
  final bool success;
  final String message;
  final Message data;

  SendMessageResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SendMessageResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SendMessageResponse.empty();
    }

    final dataJson = json['data'];

    return SendMessageResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: dataJson is Map<String, dynamic>
          ? Message.fromJson(dataJson)
          : Message.empty(),
    );
  }

  factory SendMessageResponse.empty() =>
      SendMessageResponse(success: false, message: '', data: Message.empty());
}
