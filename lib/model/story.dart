import 'package:hackernews/util/string_helper.dart';

class Story {
  final String by;

  // final int descendants;
  final int id;
  final String time;
  final String title;
  final String type;
  final String url;
  final String score;
  List<int> commentIds = <int>[];

  Story(
      {
      // required this.descendants,
      required this.id,
      required this.time,
      required this.by,
      required this.title,
      required this.type,
      required this.url,
      required this.score,
      required this.commentIds});

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
        by: json['by'],
        // descendants: json['descendants'],
        id: json['id'],
        score: json['score'].toString(),
        // time: json['time'].toString(),
        time: StringHelper().formattedDateTime(json['time']),
        title: json['title'],
        type: json['type'],
        url: json['url'] ?? '',
        commentIds: json["kids"] == null ? <int>[] : json["kids"].cast<int>());
  }
}

/*

{
"by" : "dhouston",
"descendants" : 71,
"id" : 8863,
"kids" : [ 9224, 8917, 8952, 8958, 8884, 8887, 8869, 8940, 8908, 9005, 8873, 9671, 9067, 9055, 8865, 8881, 8872, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8870, 8878, 8980, 8934, 8943, 8876 ],
"score" : 104,
"time" : 1175714200,
"title" : "My YC app: Dropbox - Throw away your USB drive",
"type" : "story",
"url" : "http://www.getdropbox.com/u/2/screencast.html"
}
*/
