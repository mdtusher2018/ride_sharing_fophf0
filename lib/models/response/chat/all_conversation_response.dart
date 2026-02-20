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

  factory AllConversationResponse.fromJson(Map<String, dynamic> json) {
    return AllConversationResponse(
      success: json['success'],
      message: json['message'],
      data: List<ConversationModel>.from(
        ((json['data'] as List?) ?? []).map(
          (x) => ConversationModel.fromJson(x),
        ),
      ),
    );
  }
}

