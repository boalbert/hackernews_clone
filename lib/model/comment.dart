
import 'package:hackernews/model/story.dart';

class Comment {
  String text = "";
  final int commentId;
  late final Story story;

  Comment({required this.text, required this.commentId});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(commentId: json["id"], text: json["text"] ?? 'No comment');
  }
}
