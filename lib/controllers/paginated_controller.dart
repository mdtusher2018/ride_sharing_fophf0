import 'package:flutter/foundation.dart';
import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';

class PaginationState<T> {
  final List<T> items;
  final PaginationMetaModel meta;
  final bool isLoadingMore;
  final bool hasMore;
  final Object? extraState;

  PaginationState({
    required this.items,
    required this.meta,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.extraState,
  });

  PaginationState<T> copyWith({
    List<T>? items,
    PaginationMetaModel? meta,
    bool? isLoadingMore,
    bool? hasMore,
    Object? extraState,
  }) {
    return PaginationState(
      items: items ?? this.items,
      meta: meta ?? this.meta,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      extraState: extraState ?? this.extraState,
    );
  }

  factory PaginationState.initial({Object? extraState}) {
    return PaginationState(
      items: [],
      meta: PaginationMetaModel(page: 1, limit: 10, total: 0, totalPage: 1),
      hasMore: true,
      extraState: extraState,
    );
  }
}

abstract class PaginationNotifier<T> extends BaseNotifier<PaginationState<T>> {
  PaginationNotifier({Object? extraState})
    : super(PaginationState.initial(extraState: extraState));

  /// API call function must be implemented
  Future<(List<T>, PaginationMetaModel)> fetchPage({
    required int page,
    required int limit,
  });

  @mustCallSuper
  Future<void> refresh() async {
    await safeCall(
      task: () async {
        final (items, meta) = await fetchPage(page: 1, limit: state.meta.limit);

        state = state.copyWith(
          items: items,
          meta: meta,
          hasMore: meta.page < meta.totalPage,
        );
      },
    );
  }

  @nonVirtual
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.meta.page + 1;

    final result = await safeCall(
      showErrorSnack: false,
      task: () async {
        return fetchPage(page: nextPage, limit: state.meta.limit);
      },
      showLoading: false,
    );

    if (result == null) {
      state = state.copyWith(isLoadingMore: false);
      return;
    }

    final (newItems, meta) = result;

    state = state.copyWith(
      items: [...state.items, ...newItems],
      meta: meta,
      isLoadingMore: false,
      hasMore: meta.page < meta.totalPage,
    );
  }
}
