import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationNotifier<T> extends StateNotifier<AsyncValue<List<T>>> {
  PaginationNotifier(
      {required this.fetchNextComments, required this.commentsPerBatch})
      : super(const AsyncValue.loading());

  final Future<List<T>> Function() fetchNextComments;
  final int commentsPerBatch;
  final List<T> _comments = [];
  bool isLoading = false;

  void init() {
    if (_comments.isEmpty) {
      fetchFirstBatch();
    }
  }

  void updateData(List<T> result) {
    if (result.isEmpty) {
      state = AsyncValue.data(_comments);
    } else {
      state = AsyncValue.data(_comments..addAll(result));
    }
  }

  Future<void> fetchFirstBatch() async {
    try {
      state = const AsyncValue.loading();
      final List<T> result = await fetchNextComments();
      updateData(result);
    } catch (e, stk) {
      state = AsyncValue.error(e, stk);
    }
  }

  Future<void> fetchNextBatch() async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    state = AsyncValue.data(_comments);
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await fetchNextComments();
      updateData(result);
    } catch (e, stk) {
      state = AsyncValue.error(e, stk);
    }
    isLoading = false;
  }
}
