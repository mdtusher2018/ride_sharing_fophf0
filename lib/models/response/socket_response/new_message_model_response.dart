class NewMessageSocketResponse {
  String bookingId;
  String sender;
  String receiver;
  String content;
  bool isRead;
  String id;

  NewMessageSocketResponse({
    required this.bookingId,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.id,
    required this.isRead,
  });

  factory NewMessageSocketResponse.fromJson(Map<String, dynamic> json) {
    return NewMessageSocketResponse(
      bookingId: json['bookingId'],
      content: json['message']['content'],
      id: json['message']['_id'],
      isRead: json['message']['isRead'],
      receiver: json['message']['receiver']['_id'],
      sender: json['message']['sender']['_id'],
    );
  }
}
