import 'package:velozaje/core/utils/api_data_praser_helper.dart';

class ConversationModel {
  final String id;
  final _Message lastMessage;
  final _User otherUser;
  final int unreadCount;
  final String bookingId;

  ConversationModel({
    required this.id,
    required this.lastMessage,
    required this.otherUser,
    required this.unreadCount,
    required this.bookingId,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: JsonHelper.stringVal(json['_id']),
      lastMessage: _Message.fromJson(json['lastMessage'] ?? {}),
      otherUser: _User.fromJson(json['otherUser'] ?? {}),
      unreadCount: JsonHelper.intVal(json['unreadCount']),
      bookingId: JsonHelper.stringVal(json['bookingId']),
    );
  }
  ConversationModel copyWith({
    String? id,
    _Message? lastMessage,
    _User? otherUser,
    int? unreadCount,
    String? bookingId,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      lastMessage: lastMessage ?? this.lastMessage,
      otherUser: otherUser ?? this.otherUser,
      unreadCount: unreadCount ?? this.unreadCount,
      bookingId: bookingId ?? this.bookingId,
    );
  }
}

class _Message {
  final String content;
  final DateTime createdAt;
  final bool isRead;
  final String sender;

  _Message({
    required this.content,
    required this.createdAt,
    required this.isRead,
    required this.sender,
  });

  factory _Message.fromJson(Map<String, dynamic> json) {
    return _Message(
      content: JsonHelper.stringVal(json['content']),
      createdAt: JsonHelper.parseDate(DateTime.parse(json['createdAt'])),
      isRead: JsonHelper.boolVal(json['isRead']),
      sender: JsonHelper.stringVal(json['sender']),
    );
  }
}

class _User {
  final String id;
  final String name;
  final String image;

  final List<String> roles;

  _User({
    required this.id,
    required this.name,
    required this.roles,
    required this.image,
  });

  factory _User.fromJson(Map<String, dynamic> json) {
    return _User(
      id: JsonHelper.stringVal(json['_id']),
      name: JsonHelper.stringVal(json['name']),
      image: JsonHelper.stringVal(json['image']),
      roles: List<String>.from(json['roles']),
    );
  }
}
