import 'package:comments_app/models/comment_model/comment.dart';
import 'package:flutter/cupertino.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  const CommentWidget(this.comment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8), child: Text(comment.body));
  }
}
