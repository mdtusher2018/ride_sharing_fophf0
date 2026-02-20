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

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) {
    return SendMessageResponse(
      success: json['success'],
      message: json['message'],
      data: Message.fromJson(json['data']),
    );
  }
}
