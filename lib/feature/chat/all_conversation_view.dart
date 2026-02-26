import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/controllers/conversation_controller.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/utils/extention.dart';
import 'package:velozaje/feature/chat/chat_view.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/feature/widget/no_data.dart';
import 'package:velozaje/models/conversation_model.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/res/common_image.dart';

class AllConversationView extends ConsumerStatefulWidget {
  const AllConversationView({super.key});

  @override
  ConsumerState<AllConversationView> createState() =>
      _AllConversationViewState();
}

class _AllConversationViewState extends ConsumerState<AllConversationView> {
  @override
  void initState() {
    super.initState();
    // Make the API call only once when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        ref.read(conversationControllerProvider.notifier).getAllConversations();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state =
        (ref.watch(conversationControllerProvider).extraState
            as ConversationState);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: CommonText(
          AppLocalizations.of(context)!.inbox,
          size: 21.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        children: [
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
                  hintText: AppLocalizations.of(context)!.search_chats,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),

          /// 💬 Chat List
          Expanded(
            child: Consumer(
              builder: (_, context, _) {
                if (state.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    ref
                        .read(conversationControllerProvider.notifier)
                        .getAllConversations();
                  },
                  child: (state.allConversations.isEmpty)
                      ? EmptyStateWidget(
                          icon: Icons.chat,
                          title: "No Conversations",
                          description: "Your messages will show up here.",
                          buttonText: "Refresh",
                          onButtonPressed: () {
                            ref
                                .read(conversationControllerProvider.notifier)
                                .getAllConversations();
                          },
                        )
                      : ListView.builder(
                          itemCount: state.allConversations.length,

                          itemBuilder: (context, index) {
                            return _ChatTile(
                              conversation: state.allConversations[index],
                            );
                          },
                        ),
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
  final ConversationModel conversation;

  const _ChatTile({required this.conversation});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ChatPage(
                bookingId: conversation.bookingId,
                reciverId: conversation.otherUser.id,
                reciverImage: conversation.otherUser.id,
                reciverName: conversation.otherUser.name,
              );
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
            path: conversation.otherUser.image,
            sourceType: ImageSourceType.network,

            height: 52.w,
          ),
        ),

        /// 🧑 Name
        title: CommonText(
          conversation.otherUser.name,
          size: 15.sp,
          fontWeight: FontWeight.w600,
        ),

        /// 💬 Last Message
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: CommonText(
            conversation.lastMessage.content,
            size: 13.sp,
            color: AppColors.textSecondary,
            maxline: 1,
          ),
        ),

        /// ⏰ Time + 🔔 Unread Badge
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!conversation.lastMessage.isRead)
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
                child: CommonText(
                  "".toString(),
                  size: 10.sp,
                  color: Colors.white,
                ),
              ),
            CommonText(
              conversation.lastMessage.createdAt.customFormat(),
              size: 11.sp,
            ),
          ],
        ),
      ),
    );
  }
}
