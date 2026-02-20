import 'dart:developer';

import 'package:velozaje/controllers/paginated_controller.dart';
import 'package:velozaje/core/services/api/i_api_service.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/models/conversation_model.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';

import 'package:velozaje/models/response/chat/all_conversation_response.dart';
import 'package:velozaje/models/response/chat/messages_for_a_spacific_conversation_response.dart';
import 'package:velozaje/models/response/chat/send_message_response.dart';
import 'package:velozaje/models/response/chat/unread_message_count_response.dart';

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

  // Constructor
  ConversationController(this.apiService)
    : super(extraState: ConversationState.initial());

  // Fetch all conversations
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

  // Fetch unread message count
  Future<void> getUnreadMessageCount() async {
    final response = await apiService.get(ApiEndpoints.unreadMessage);
    final result = UnreadMessageCountResponse.fromJson(response);
    final currentState = state.extraState as ConversationState?;
    if (currentState == null) return;

    state = state.copyWith(
      extraState: currentState.copyWith(unreadCount: result.count),
    );
  }

  // Send message for a specific booking
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
            ...state.items,
            ...[result.data],
          ],
        );
      },
      showLoading: false,
    );
  }

  // // Get conversation details for a specific booking
  // Future<void> getConversationForBooking(String bookingId) async {
  //   final response = await apiService.get(
  //     ApiEndpoints.conversationForSpacificBooking(bookingId),
  //   );
  //   final result = ConversationDetailsResponse.fromJson(response);
  //   final conversation = result.data;

  //   // Set conversation details in the state
  //   setState(
  //     (state) => state.copyWith(
  //       allConversations: [conversation], // Assuming one booking conversation
  //     ),
  //   );
  // }

  // // Mark messages as read
  // Future<void> markMessagesAsRead(String bookingId) async {
  //   final response = await apiService.post(ApiEndpoints.readMessage(bookingId));
  //   final result = MarkMessagesReadResponse.fromJson(response);

  //   // Update unread count and state
  //   setState((state) => state.copyWith(unreadCount: 0));
  // }
}
