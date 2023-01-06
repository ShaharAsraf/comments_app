import 'package:comments_app/models/comment_model/comment.dart';
import 'package:comments_app/src/pagination_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_provider.dart';

final Provider apiProvider = Provider<ApiProvider>((ref) => ApiProvider());
final commentsProvider = StateNotifierProvider<PaginationNotifier<Comment>,
    AsyncValue<List<Comment>>>((ref) {
  return PaginationNotifier(
      fetchNextComments: () => ref.read(apiProvider).fetchComments(),
      commentsPerBatch: 20)
    ..init();
});
