import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/components/small_card_text.dart';
import 'package:hackernews/util/string_helper.dart';

class StoryCard extends StatelessWidget {
  const StoryCard(
      {Key? key,
      required this.title,
      required this.score,
      required this.by,
      required this.url,
      required this.comments,
      required this.time})
      : super(key: key);

  final String title;
  final String score;
  final String by;
  final String url;
  final int comments;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(url),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (StringHelper().parseHost(url) != '')
                  Text(
                    StringHelper().parseHost(url),
                    key: Key(url),
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                Text(
                  title,
                  key: Key(title),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
          ),
          Row(
            children: [
              SmallCardText(
                  key: Key(by), text: by, fontWeight: FontWeight.w300),
              SmallCardText(
                  key: Key(by + time),
                  text: ' - ',
                  fontWeight: FontWeight.w200),
              SmallCardText(
                  key: Key(time), text: time, fontWeight: FontWeight.w200),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
          Row(
            children: [
              Text(
                score + ' points',
                key: Key(score + by),
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
              ),
              Text(
                ' - ',
                key: Key(by + score),
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
              ),
              Text("$comments comments",
                  key: Key(comments.toString() + by),
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 11)),
            ],
          )
        ],
      ),
    );
  }
}
