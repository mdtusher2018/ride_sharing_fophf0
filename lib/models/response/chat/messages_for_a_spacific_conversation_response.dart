import 'package:velozaje/core/utils/api_data_praser_helper.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';

class MessagesForASpacificResponse {
  final bool success;
  final String message;
  final MessagesData data;

  MessagesForASpacificResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MessagesForASpacificResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return MessagesForASpacificResponse.empty();
    }

    return MessagesForASpacificResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: MessagesData.fromJson(json['data']),
    );
  }

  factory MessagesForASpacificResponse.empty() => MessagesForASpacificResponse(
    success: false,
    message: '',
    data: MessagesData.empty(),
  );
}

class MessagesData {
  final List<Message> messages;
  final PaginationMetaModel pagination;

  MessagesData({required this.messages, required this.pagination});

  factory MessagesData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return MessagesData.empty();

    return MessagesData(
      messages: JsonHelper.safeList(
        json['messages'],
        (e) => Message.fromJson(e),
      ),
      pagination: PaginationMetaModel.fromJson(json['pagination']),
    );
  }

  factory MessagesData.empty() =>
      MessagesData(messages: [], pagination: PaginationMetaModel.fromJson({}));
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

  factory Message.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Message.empty();

    return Message(
      id: JsonHelper.stringVal(json['_id']),
      receiver: Sender.fromJson(json['receiver']),
      sender: Sender.fromJson(json['sender']),
      booking: JsonHelper.stringVal(json['booking']),
      content: JsonHelper.stringVal(json['content']),
      isRead: JsonHelper.boolVal(json['isRead']),
      createdAt: JsonHelper.parseDate(json['createdAt']),
      updatedAt: JsonHelper.parseDate(json['updatedAt']),
    );
  }

  factory Message.empty() => Message(
    id: '',
    receiver: Sender.empty(),
    sender: Sender.empty(),
    booking: '',
    content: '',
    isRead: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}

class Sender {
  final String id;

  Sender({required this.id});

  factory Sender.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Sender.empty();

    return Sender(id: JsonHelper.stringVal(json['_id']));
  }

  factory Sender.empty() => Sender(id: '');
}
