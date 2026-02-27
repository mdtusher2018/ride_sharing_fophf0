import 'package:velozaje/core/utils/api_data_praser_helper.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';

class NotificationsResponse {
  final bool success;
  final String message;
  final NotificationsData data;

  NotificationsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return NotificationsResponse(
        success: false,
        message: '',
        data: NotificationsData.empty(),
      );
    }

    return NotificationsResponse(
      success: JsonHelper.boolVal(json['success']),
      message: JsonHelper.stringVal(json['message']),
      data: NotificationsData.fromJson(json['data']),
    );
  }
}

class NotificationsData {
  final List<NotificationItem> notifications;
  final PaginationMetaModel pagination;

  NotificationsData({required this.notifications, required this.pagination});

  factory NotificationsData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return NotificationsData.empty();

    return NotificationsData(
      notifications: JsonHelper.safeList(
        json['notifications'],
        (e) => NotificationItem.fromJson(e),
      ),
      pagination: PaginationMetaModel.fromJson(json['pagination']),
    );
  }

  factory NotificationsData.empty() => NotificationsData(
    notifications: [],
    pagination: PaginationMetaModel.fromJson({}),
  );
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
  final DateTime? createdAt;
  final DateTime? updatedAt;

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

  factory NotificationItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) return NotificationItem.empty();

    return NotificationItem(
      id: JsonHelper.stringVal(json['_id']),
      user: JsonHelper.stringVal(json['user']),
      title: JsonHelper.stringVal(json['title']),
      message: JsonHelper.stringVal(json['message']),
      type: JsonHelper.stringVal(json['type']),
      isRead: JsonHelper.boolVal(json['isRead']),
      relatedEntity: RelatedEntity.fromJson(json['relatedEntity']),
      metadata: NotificationMetadata.fromJson(json['metadata']),
      createdAt: JsonHelper.parseDate(json['createdAt']),
      updatedAt: JsonHelper.parseDate(json['updatedAt']),
    );
  }

  factory NotificationItem.empty() => NotificationItem(
    id: '',
    user: '',
    title: '',
    message: '',
    type: '',
    isRead: false,
    relatedEntity: RelatedEntity.empty(),
    metadata: NotificationMetadata.empty(),
    createdAt: null,
    updatedAt: null,
  );

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

  factory RelatedEntity.fromJson(Map<String, dynamic>? json) {
    if (json == null) return RelatedEntity.empty();

    return RelatedEntity(
      entityType: JsonHelper.stringVal(json['entityType']),
      entityId: JsonHelper.stringVal(json['entityId']),
    );
  }

  factory RelatedEntity.empty() => RelatedEntity(entityType: '', entityId: '');
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

  factory NotificationMetadata.fromJson(Map<String, dynamic>? json) {
    if (json == null) return NotificationMetadata.empty();

    return NotificationMetadata(
      rating: JsonHelper.stringVal(json['rating']),
      reviewId: JsonHelper.stringVal(json['reviewId']),
      tripId: JsonHelper.stringVal(json['tripId']),
      earnings: json['earnings'] != null
          ? JsonHelper.intVal(json['earnings'])
          : null,
    );
  }

  factory NotificationMetadata.empty() => NotificationMetadata();
}
