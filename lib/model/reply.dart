import 'package:hackernews/util/string_helper.dart';

class Reply {
  final String by;
  final int id;
  final int parent;
  final String text;
  final String time;
  final String type;

  Reply(
      {required this.by,
      required this.id,
      required this.parent,
      required this.text,
      required this.time,
      required this.type});

  @override
  String toString() {
    return 'Reply{by: $by, id: $id, parent: $parent, text: $text, time: $time, type: $type}';
  }

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
        by: json['by'] ?? '[Deleted]',
        id: json['id'],
        parent: json['parent'] ?? 0,
        text: json["text"] ?? 'No comment',
        time: StringHelper().formattedDateTime(json['time']),
        type: json['type']);
  }
}
