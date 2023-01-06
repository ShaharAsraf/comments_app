import 'package:comments_app/models/comment_model/comment.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  const CommentWidget(this.comment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderName(),
            _renderSpace(),
            _renderEmail(),
            _renderSpace(),
            _renderBody(),
          ],
        ),
      ),
    );
  }

  Widget _renderSpace() => const SizedBox(height: 5);

  Widget _renderName() {
    return Text(
      comment.name,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _renderEmail() {
    return Text(
      comment.email,
      style: const TextStyle(fontSize: 16),
    );
  }

  Widget _renderBody() {
    return Text(
      comment.body,
      style: const TextStyle(fontSize: 14),
    );
  }
}
