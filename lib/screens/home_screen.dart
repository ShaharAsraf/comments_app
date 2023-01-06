import 'package:comments_app/src/providers.dart';
import 'package:comments_app/widgets/scroll_button.dart';
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
        actions: [
          _renderAddComment(context, ref),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        alignment: Alignment.center,
        child: comments.when(
          data: (data) => ListView(
            controller: scrollController,
            children: [
              ...data.map((c) => CommentWidget(c)).toList(),
              _renderLoading(),
            ],
          ),
          loading: _renderLoading,
          error: (error, _) => const Text(
            'error',
          ),
        ),
      ),
      floatingActionButton: ScrollButton(scrollController: scrollController),
    );
  }

  Widget _renderLoading() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            )),
      ),
    );
  }

  Widget _renderAddComment(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      child: Center(
        child: Container(
          height: 36,
          width: 36,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.add,
              size: 20,
              color: Colors.black54,
            ),
            onPressed: () => _addCommentDialog(context, ref),
          ),
        ),
      ),
    );
  }

  Future<void> _addCommentDialog(BuildContext context, WidgetRef ref) {
    TextEditingController textController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add comment to Cambium'),
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('send'),
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(apiProvider).addComment(textController.text);
              },
            ),
          ],
        );
      },
    );
  }

  void scrollListener(WidgetRef ref) async {
    final double maxScroll = 0.9 * scrollController.position.maxScrollExtent;
    final double currentScroll = scrollController.position.pixels;
    if (currentScroll >= maxScroll) {
      ref.read(commentsProvider.notifier).fetchNextBatch();
    }
  }
}
