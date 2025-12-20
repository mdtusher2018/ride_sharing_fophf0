import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/chat/chat_view.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/res/common_image.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: CommonText('Inbox', size: 21.sp, fontWeight: FontWeight.w600),
      ),
      body: Column(
        children: [
          /// 🔍 Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              padding: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.25),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search_rounded, color: Colors.grey),
                  hintText: 'Search chats',
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),

          /// 💬 Chat List
          Expanded(
            child: ListView.builder(
              itemCount: 10,

              itemBuilder: (context, index) {
                return _ChatTile(
                  image:
                      "https://static.vecteezy.com/system/resources/previews/002/002/403/non_2x/man-with-beard-avatar-character-isolated-icon-free-vector.jpg",
                  name: 'Username $index',
                  message: 'Hey! Your document is verified.',
                  time: '5 min',
                  unreadCount: index < 2 ? 2 : 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final String image;
  final String name;
  final String message;
  final String time;
  final int unreadCount;

  const _ChatTile({
    required this.image,
    required this.name,
    required this.message,
    required this.time,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ChatPage();
            },
          ),
        );
      },
      child: ListTile(
        /// 👤 Avatar
        contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        leading: CircleAvatar(
          radius: 30.r,
          child: CommonImage(
            path: image,
            sourceType: ImageSourceType.network,

            height: 52.w,
          ),
        ),

        /// 🧑 Name
        title: CommonText(name, size: 15.sp, fontWeight: FontWeight.w600),

        /// 💬 Last Message
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: CommonText(
            message,
            size: 13.sp,
            color: AppColors.textSecondary,
            maxline: 1,
          ),
        ),

        /// ⏰ Time + 🔔 Unread Badge
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonText(time, size: 11.sp, color: Colors.grey),

            if (unreadCount > 0)
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: CommonText(
                  unreadCount.toString(),
                  size: 10.sp,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
