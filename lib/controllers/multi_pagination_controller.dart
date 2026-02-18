import 'package:velozaje/controllers/paginated_controller.dart';
import 'package:velozaje/core/base_notifier.dart';
import 'package:velozaje/models/pagenation_meta_model.dart';

class MultiPaginationState<K, T> {
  final Map<K, PaginationState<T>> pages;

  MultiPaginationState({required this.pages});

  PaginationState<T> of(K key) => pages[key] ?? PaginationState.initial();

  MultiPaginationState<K, T> copyWithKey(K key, PaginationState<T> value) {
    final newPages = Map<K, PaginationState<T>>.from(pages);
    newPages[key] = value;
    return MultiPaginationState(pages: newPages);
  }

  factory MultiPaginationState.initial() {
    return MultiPaginationState(pages: {});
  }
}

abstract class MultiPaginationNotifier<K, T>
    extends BaseNotifier<MultiPaginationState<K, T>> {
  MultiPaginationNotifier() : super(MultiPaginationState.initial());

  Future<(List<T>, PaginationMetaModel)> fetchPage({
    required K key,
    required int page,
    required int limit,
  });

  PaginationState<T> _stateOf(K key) => state.of(key);

  Future<void> refresh(K key) async {
    final current = _stateOf(key);

    final result = await safeCall(
      task: () async {
        return fetchPage(key: key, page: 1, limit: current.meta.limit);
      },
    );

    if (result == null) return;

    final (items, meta) = result;

    final updated = current.copyWith(
      items: items,
      meta: meta,
      hasMore: meta.page < meta.totalPage,
    );

    state = state.copyWithKey(key, updated);
  }

  Future<void> loadMore(K key) async {
    final current = _stateOf(key);

    if (current.isLoadingMore || !current.hasMore) return;

    final loadingState = current.copyWith(isLoadingMore: true);

    state = state.copyWithKey(key, loadingState);

    final nextPage = current.meta.page + 1;

    final result = await safeCall(
      showErrorSnack: false,
      task: () async {
        return fetchPage(key: key, page: nextPage, limit: current.meta.limit);
      },
    );

    if (result == null) {
      state = state.copyWithKey(key, current.copyWith(isLoadingMore: false));
      return;
    }

    final (items, meta) = result;

    final updated = current.copyWith(
      items: [...current.items, ...items],
      meta: meta,
      isLoadingMore: false,
      hasMore: meta.page < meta.totalPage,
    );

    state = state.copyWithKey(key, updated);
  }
}
