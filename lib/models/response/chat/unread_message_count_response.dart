class UnreadMessageCountResponse {
  final bool success;
  final String message;
  final int count;

  UnreadMessageCountResponse({
    required this.success,
    required this.message,
    required this.count,
  });

  // Factory constructor to create a new instance from JSON
  factory UnreadMessageCountResponse.fromJson(Map<String, dynamic> json) {
    return UnreadMessageCountResponse(
      success: json['success'],
      message: json['message'],
      count: json['data']['count'],
    );
  }
}
