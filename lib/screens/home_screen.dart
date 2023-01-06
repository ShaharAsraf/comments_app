import 'package:comments_app/src/providers.dart';
import 'package:comments_app/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comments = ref.watch(commentsProvider);
    scrollController.addListener(() => scrollListener(ref));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shahar's comments feed"),
      ),
      body: Center(
        child: comments.when(
          data: (data) => ListView(
            controller: scrollController,
            children: data.map((c) => CommentWidget(c)).toList(),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => const Text(
            'error',
          ),
        ),
      ),
    );
  }

  void scrollListener(WidgetRef ref) async {
    double maxScroll = 0.9 * scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    if (currentScroll >= maxScroll) {
      ref.read(commentsProvider.notifier).fetchNextBatch();
    }
  }
}
