import 'package:velozaje/models/pagenation_meta_model.dart';
import 'package:velozaje/controllers/paginated_controller.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/feature/notifications/notification_model.dart';

class NotificationController extends PaginationNotifier<NotificationItem> {
  final IApiService apiService;
  int unreadCount = 0;
  NotificationController(this.apiService);

  @override
  Future<(List<NotificationItem>, PaginationMetaModel)> fetchPage({
    required int page,
    required int limit,
  }) async {
    final response = await apiService.get(ApiEndpoints.notification);

    final notification = NotificationsResponse.fromJson(response);

    return (notification.data.notifications, notification.data.pagination);
  }

  Future<void> unreadNotificationCount() async {
    safeCall(
      task: () async {
        final response = await apiService.get(
          ApiEndpoints.unreadNotificationCount,
        );
        unreadCount = response['data']?['count'] ?? 0;
      },
    );
  }

  Future<void> markAllAsRead() async {
    return await safeCall(
      task: () async {
        final response = await apiService.patch(ApiEndpoints.markAllAsRead, {});
        if (response['success']) {
          unreadCount = 0;
        }
      },
    );
  }

  Future<void> markAsRead(String id) async {
    return await safeCall(
      task: () async {
        final response = await apiService.patch(
          ApiEndpoints.markAsRead(id),
          {},
        );
        if (response['success']) {
          final updated = state.items.map((e) {
            if (e.id == id && !e.isRead) {
              unreadCount = unreadCount > 0 ? unreadCount - 1 : 0;

              return e.copyWith(isRead: true);
            }
            return e;
          }).toList();

          state = state.copyWith(items: updated);
        }
      },
    );
  }
}
