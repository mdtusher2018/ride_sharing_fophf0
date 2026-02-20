import 'package:velozaje/models/pagenation_meta_model.dart';

class MessagesForASpacificResponse {
  final bool success;
  final String message;
  final Data data;

  MessagesForASpacificResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  // Factory constructor to create a new instance from JSON
  factory MessagesForASpacificResponse.fromJson(Map<String, dynamic> json) {
    return MessagesForASpacificResponse(
      success: json['success'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final List<Message> messages;
  final PaginationMetaModel pagination;

  Data({required this.messages, required this.pagination});

  // Factory constructor to create a new instance from JSON
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      messages: (json['messages'] as List)
          .map((messageJson) => Message.fromJson(messageJson))
          .toList(),
      pagination: PaginationMetaModel.fromJson(json['pagination']),
    );
  }
}

class Message {
  final String id;
  final Sender receiver;
  final Sender sender;
  final String booking;
  final String content;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  Message({
    required this.id,
    required this.receiver,
    required this.sender,
    required this.booking,
    required this.content,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a new instance from JSON
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      receiver: Sender.fromJson(json['receiver']),
      sender: Sender.fromJson(json['sender']),
      booking: json['booking'],
      content: json['content'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Sender {
  final String id;

  Sender({required this.id});

  // Factory constructor to create a new instance from JSON
  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(id: json['_id']);
  }
}
