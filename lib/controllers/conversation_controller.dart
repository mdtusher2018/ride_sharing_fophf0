import 'dart:developer';

import 'package:velozaje/controllers/paginated_controller.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/services/socket/socket_events.dart';
import 'package:velozaje/core/services/socket/socket_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/feature/root_view.dart';
import 'package:velozaje/models/conversation_model.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';

import 'package:velozaje/models/response/chat/all_conversation_response.dart';
import 'package:velozaje/models/response/chat/messages_for_a_spacific_conversation_response.dart';
import 'package:velozaje/models/response/chat/send_message_response.dart';
import 'package:velozaje/models/response/chat/unread_message_count_response.dart';
import 'package:velozaje/models/response/socket_response/new_message_model_response.dart';

class ConversationState {
  final List<ConversationModel> allConversations;
  final int unreadCount;
  final bool isLoading;
  final String selectedConversation;

  const ConversationState({
    this.allConversations = const [],
    this.unreadCount = 0,
    this.isLoading = false,
    this.selectedConversation = "",
  });

  factory ConversationState.initial() {
    return const ConversationState();
  }

  ConversationState copyWith({
    List<ConversationModel>? allConversations,
    int? unreadCount,
    String? selectedConversation,
    bool? isLoading,
  }) {
    return ConversationState(
      allConversations: allConversations ?? this.allConversations,
      unreadCount: unreadCount ?? this.unreadCount,
      selectedConversation: selectedConversation ?? this.selectedConversation,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ConversationController extends PaginationNotifier<Message> {
  final IApiService apiService;
  final SocketService socketService;

  ConversationController(this.apiService, this.socketService)
    : super(extraState: ConversationState.initial());

  Future<void> getAllConversations() async {
    safeCall(
      task: () async {
        final response = await apiService.get(ApiEndpoints.allConversation);

        final result = AllConversationResponse.fromJson(response);
        final currentState = state.extraState as ConversationState?;
        log(result.data.length.toString());
        if (currentState == null) return;

        state = state.copyWith(
          extraState: currentState.copyWith(allConversations: result.data),
        );
      },
    );
  }

  Future<void> loadaSpacificConversation({required String id}) async {
    state = state.copyWith(
      extraState: (state.extraState as ConversationState).copyWith(
        selectedConversation: id,
        isLoading: true,
      ),
    );

    super.refresh();
    state = state.copyWith(
      extraState: (state.extraState as ConversationState).copyWith(
        isLoading: false,
      ),
    );
    markAsRead();
  }

  @override
  Future<(List<Message>, PaginationMetaModel)> fetchPage({
    required int page,
    required int limit,
  }) async {
    final currentState = state.extraState as ConversationState?;

    final response = await apiService.get(
      ApiEndpoints.conversationForSpacificBooking(
        currentState?.selectedConversation ?? "",
      ),
      queryParameters: {'page': page.toString(), 'limit': limit.toString()},
    );

    final messagesResponse = MessagesForASpacificResponse.fromJson(response);
    return (messagesResponse.data.messages, messagesResponse.data.pagination);
  }

  Future<void> getUnreadMessageCount() async {
    final response = await apiService.get(ApiEndpoints.unreadMessage);
    final result = UnreadMessageCountResponse.fromJson(response);
    final currentState = state.extraState as ConversationState?;
    if (currentState == null) return;

    state = state.copyWith(
      extraState: currentState.copyWith(unreadCount: result.count),
    );
  }

  Future<void> markAsRead() async {
    safeCall(
      showLoading: false,
      showErrorSnack: false,
      showSuccessSnack: false,
      task: () async {
        final currentState = state.extraState as ConversationState?;
        await apiService.patch(
          ApiEndpoints.conversationMarkAsRead(
            currentState?.selectedConversation ?? "",
          ),
          {},
        );
      },
    );
  }

  void makeAllRead() {
    final currentState = state.extraState as ConversationState?;
    if (currentState == null) return;
    state = state.copyWith(extraState: currentState.copyWith(unreadCount: 0));
  }

  Future<void> sendMessage({
    required String content,
    required String bookingId,
    required String receiverId,
  }) async {
    final fields = {
      'content': content,
      'booking': bookingId,
      'receiver': receiverId,
    };

    return await safeCall(
      task: () async {
        final response = await apiService.post(
          ApiEndpoints.sendMessage,
          fields,
        );
        final result = SendMessageResponse.fromJson(response);
        state = state.copyWith(
          items: [
            ...[result.data],
            ...state.items,
          ],
        );
      },
      showLoading: false,
    );
  }

  void joinPrivateRoom(String userId) {
    socketService.on(SocketEvents.joined, (data) {
      log(data.toString());
    });
    socketService.emit(SocketEvents.join, userId);
    newMessage();
  }

  //have a issue unread count increase multiple times
  void newMessage() {
    socketService.on(SocketEvents.newMessage, (data) {
      final response = NewMessageSocketResponse.fromJson(data);

      final currentState = state.extraState as ConversationState?;

      if (currentState == null) return;
      log("current page= ${RootPage.currentIndex}");

      final updatedConversations = currentState.allConversations.map((
        conversation,
      ) {
        if (conversation.bookingId == response.bookingId) {
          return conversation.copyWith(
            unreadCount: (conversation.unreadCount + 1),
          );
        }
        return conversation;
      }).toList();

      state = state.copyWith(
        extraState: currentState.copyWith(
          allConversations: updatedConversations,
          unreadCount: RootPage.currentIndex != 2 ? 1 : 0,
        ),
      );
    });
  }
}
