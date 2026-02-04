import 'package:velozaje/core/model/pagenation_meta_model.dart';

class NotificationsResponse {
  final bool success;
  final String message;
  final NotificationsData data;

  NotificationsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      success: json['success'],
      message: json['message'],
      data: NotificationsData.fromJson(json['data']),
    );
  }
}

class NotificationsData {
  final List<NotificationItem> notifications;
  final Meta pagination;

  NotificationsData({required this.notifications, required this.pagination});

  factory NotificationsData.fromJson(Map<String, dynamic> json) {
    return NotificationsData(
      notifications: (json['notifications'] as List)
          .map((e) => NotificationItem.fromJson(e))
          .toList(),
      pagination: Meta.fromJson(json['pagination']),
    );
  }
}

class NotificationItem {
  final String id;
  final String user;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final RelatedEntity relatedEntity;
  final NotificationMetadata metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationItem({
    required this.id,
    required this.user,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.relatedEntity,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['_id'],
      user: json['user'],
      title: json['title'],
      message: json['message'],
      type: json['type'],
      isRead: json['isRead'],
      relatedEntity: RelatedEntity.fromJson(json['relatedEntity']),
      metadata: NotificationMetadata.fromJson(json['metadata']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  NotificationItem copyWith({
    String? id,
    String? user,
    String? title,
    String? message,
    String? type,
    bool? isRead,
    RelatedEntity? relatedEntity,
    NotificationMetadata? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      user: user ?? this.user,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      relatedEntity: relatedEntity ?? this.relatedEntity,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class RelatedEntity {
  final String entityType;
  final String entityId;

  RelatedEntity({required this.entityType, required this.entityId});

  factory RelatedEntity.fromJson(Map<String, dynamic> json) {
    return RelatedEntity(
      entityType: json['entityType'],
      entityId: json['entityId'],
    );
  }
}

class NotificationMetadata {
  final String? rating;
  final String? reviewId;
  final String? tripId;
  final int? earnings;

  NotificationMetadata({
    this.rating,
    this.reviewId,
    this.tripId,
    this.earnings,
  });

  factory NotificationMetadata.fromJson(Map<String, dynamic> json) {
    return NotificationMetadata(
      rating: json['rating'],
      reviewId: json['reviewId'],
      tripId: json['tripId'],
      earnings: json['earnings'],
    );
  }
}
