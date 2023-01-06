import 'package:comments_app/models/comment_model/comment.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  int _start = 0;
  int _end = 20;
  String get start => _start.toString();
  String get end => _end.toString();

  Future<List<Comment>> fetchComments() async {
    final Uri uri = Uri.parse(
        'https://jsonplaceholder.typicode.com/comments?_start=$start&_end=$end');
    final response = await Dio().getUri(uri);
    increment();
    return (response.data as List<dynamic>)
        .map((e) => Comment.fromJson(e))
        .toList();
  }

  void addComment(String data) async {
    try {
      final Response response = await Dio()
          .post('https://cambium.co.il/test/testAssignComment', data: data);
      return;
    } catch (e, stk) {
      return;
    }
  }

  void increment() {
    _start += 20;
    _end += 20;
  }
}
