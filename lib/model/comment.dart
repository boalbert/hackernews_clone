import 'package:hackernews/model/story.dart';
import 'package:hackernews/util/string_helper.dart';

class Comment {
  late final Story story;

  final String by;
  final int id;

  final int parent;
  final String text;

  final String time;
  final String type;

  Comment(
      {required this.by,
      required this.id,
      required this.parent,
      required this.text,
      required this.time,
      required this.type});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        by: json['by'] ?? '[Deleted]',
        id: json['id'],
        parent: json['parent'] ?? 0,
        text: json["text"] ?? 'No comment',
        time: StringHelper().formattedDateTime(json['time']),
        type: json['type']);
  }
}
