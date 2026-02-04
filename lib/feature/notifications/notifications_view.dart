import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/feature/notifications/notification_model.dart';
import 'package:velozaje/feature/notifications/notifications_controller.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_text.dart';

class NotificationView extends ConsumerStatefulWidget {
  const NotificationView({super.key});

  @override
  ConsumerState<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends ConsumerState<NotificationView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(myNotificationsControllerProvider.notifier).refresh();
    });

    final controller = ref.read(myNotificationsControllerProvider.notifier);
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 200) {
        controller.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pagination = ref.watch(myNotificationsControllerProvider);
    final notifier = ref.read(myNotificationsControllerProvider.notifier);

    final notifications = pagination.items;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar(title: 'Notification', context),
      body: ValueListenableBuilder(
        valueListenable: notifier.isLoading,
        builder: (_, isLoading, __) {
          if (isLoading && notifications.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (notifications.isEmpty) {
            return noNotification();
          }

          final grouped = _groupNotifications(notifications);

          return RefreshIndicator(
            onRefresh: () async {
              await notifier.refresh();
            },
            child: ListView(
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),

              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      ref
                          .watch(myNotificationsControllerProvider.notifier)
                          .markAllAsRead();
                    },
                    child: CommonText("Mark all as read"),
                  ),
                ),
                ...grouped.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Section Header
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      /// Notifications
                      ...entry.value.map((item) {
                        return CustomNotificationTile(
                          title: item.title,
                          subtitle: item.message,
                          isReaded: item.isRead,
                          dateTime: item.createdAt,
                          onTap: () {
                            ref
                                .watch(
                                  myNotificationsControllerProvider.notifier,
                                )
                                .markAsRead(item.id);
                          },
                        );
                      }),
                    ],
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget noNotification() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          // Wrapped icon inside a circular container with shadow
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.mainbg, // Light background color
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 4), // Slight shadow under the icon
                ),
              ],
            ),
            padding: EdgeInsets.all(
              16,
            ), // Padding for the icon within the container
            child: Icon(
              Icons.notifications_off,
              size: 60,
              color: Colors.blueGrey[400], // Softer color for elegance
            ),
          ),
          SizedBox(height: 20),
          Text(
            "No Notifications Found",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800], // Darker color for the title
            ),
          ),
          SizedBox(height: 12),
          Text(
            "You will be notified when there are updates. Please check back later.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.blueGrey[600], // Lighter text color
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 24),
          CommonButton(
            "Refresh Notifications",
            onTap: () async {
              ref.read(myNotificationsControllerProvider.notifier).refresh();
            },
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }

  Map<String, List<NotificationItem>> _groupNotifications(
    List<NotificationItem> notifications,
  ) {
    final Map<String, List<NotificationItem>> grouped = {};

    for (final notification in notifications) {
      final date = notification.createdAt;
      String key;

      if (_isToday(date)) {
        key = 'Today';
      } else if (_isYesterday(date)) {
        key = 'Yesterday';
      } else {
        key = DateFormat('MMM dd, yyyy').format(date);
      }

      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(notification);
    }

    return grouped;
  }

  bool _isToday(DateTime? date) {
    final now = DateTime.now();
    return date?.year == now.year &&
        date?.month == now.month &&
        date?.day == now.day;
  }

  bool _isYesterday(DateTime? date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date?.year == yesterday.year &&
        date?.month == yesterday.month &&
        date?.day == yesterday.day;
  }
}

class CustomNotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final DateTime dateTime;
  final bool isReaded;
  final VoidCallback? onTap;

  const CustomNotificationTile({
    super.key,

    required this.title,
    required this.subtitle,
    required this.dateTime,
    required this.isReaded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedTime = DateFormat('hh:mm a').format(dateTime);

    return ListTile(
      tileColor: isReaded ? AppColors.white : AppColors.mainbg,
      leading: Card(
        color: AppColors.white,
        shape: CircleBorder(),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.notifications_active,
            size: 32,
            color: AppColors.primary,
          ),
        ),
      ),
      title: CommonText(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(subtitle),
          const SizedBox(height: 4),
          CommonText(formattedTime),
        ],
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
