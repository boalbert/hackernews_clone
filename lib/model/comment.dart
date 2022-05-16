import 'package:hackernews/util/string_helper.dart';

class Comment {
  final String by;
  final int id;

  final int parent;
  final String text;
  final List<int> kids;

  final String time;
  final String type;

  Comment({required this.by, required this.id, required this.parent, required this.text, required this.kids, required this.time, required this.type});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        by: json['by'] ?? '[Deleted]',
        id: json['id'],
        parent: json['parent'] ?? 0,
        text: json["text"] != null ? StringHelper().encodeComments(json["text"]) : '[Deleted]',
        kids: json["kids"] == null ? <int>[] : json["kids"].cast<int>(),
        time: StringHelper().formattedDateTime(json['time']),
        type: json['type']);
    //commentIds: json["kids"] == null ? <int>[] : json["kids"].cast<int>());
  }
}
