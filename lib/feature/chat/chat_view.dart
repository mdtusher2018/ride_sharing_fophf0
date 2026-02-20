import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/core/utils/helper.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:icons_plus/icons_plus.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String bookingId;
  final String reciverId;
  final String reciverName;
  final String reciverImage;
  const ChatPage({
    super.key,
    required this.bookingId,
    required this.reciverId,
    required this.reciverImage,
    required this.reciverName,
  });

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(conversationControllerProvider.notifier)
          .loadaSpacificConversation(id: widget.bookingId);
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 200) {
        ref.watch(conversationControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(conversationControllerProvider);
    final controller = ref.watch(conversationControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.mainbg,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 1,

        titleSpacing: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 21.r,
              child: CommonImage(
                path:
                    "https://static.vecteezy.com/system/resources/previews/002/002/403/non_2x/man-with-beard-avatar-character-isolated-icon-free-vector.jpg",
                sourceType: ImageSourceType.network,
                width: 36.w,
                height: 36.w,
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText('Support', size: 15.sp, fontWeight: FontWeight.w600),
                CommonText('Online', size: 11.sp, color: Colors.green),
              ],
            ),
          ],
        ),
      ),

      /// 💬 Body
      body: Column(
        children: [
          /// Messages
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: controller.isLoading,
              builder: (context, isloading, child) {
                if (isloading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.items.isEmpty) {
                  return CommonText("No chat found. Send the frist message");
                }
                return ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),

                  itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
                  reverse: true,
                  itemBuilder: (context, index) {
                    if (index >= state.items.length) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final msg = state.items.reversed.toList()[index];
                    return _ChatBubble(
                      text: msg.content,
                      time: formatDateTime(msg.createdAt),
                      isMe: msg.sender.id == widget.reciverId,
                    );
                  },
                );
              },
            ),
          ),

          /// ✍️ Input Bar
          Container(
            padding: EdgeInsets.only(
              left: 12.w,
              right: 12.w,
              top: 8.h,
              bottom: 24.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                /// 📷 Camera Icon
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(0.15),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      size: 24.sp,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      // TODO: Open camera or gallery
                    },
                  ),
                ),

                SizedBox(width: 8.w),

                /// ✍️ Message Input
                Expanded(
                  child: TextField(
                    controller: messageController,
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.type_a_message,
                      filled: true,
                      fillColor: AppColors.grey.withOpacity(0.2),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8.w),

                /// ➤ Send Button (Smaller)
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Iconsax.send_2_bold,
                      size: 18.sp,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (messageController.text.trim().isEmpty) return;
                      controller.sendMessage(
                        content: messageController.text,
                        bookingId: widget.bookingId,
                        receiverId: widget.reciverId,
                      );

                      setState(() {
                        messageController.clear();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isMe;

  const _ChatBubble({
    required this.text,
    required this.time,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 16.h,
          left: isMe ? 60.w : 0,
          right: isMe ? 0 : 60.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: isMe ? Radius.circular(16.r) : Radius.circular(0),
            bottomRight: isMe ? Radius.circular(0) : Radius.circular(16.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            CommonText(
              text,
              size: 12.sp,
              color: isMe ? Colors.white : Colors.black,
            ),

            CommonText(
              time,
              size: 10.sp,
              color: isMe ? Colors.white : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
