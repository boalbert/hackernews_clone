import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/util/string_helper.dart';
import 'package:hackernews/widgets/small_card_text.dart';

class StoryHeader extends StatelessWidget {
  final String url;
  final String title;
  final String by;
  final String points;
  final String commentCount;
  final String time;
  final String text;

  const StoryHeader({
    Key? key,
    required this.url,
    required this.title,
    required this.by,
    required this.points,
    required this.commentCount,
    required this.time,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringHelper().parseHost(url),
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SmallCardText(
                text: by,
                fontWeight: FontWeight.w300,
                key: Key(by),
              ),
              SmallCardText(text: ' - ', fontWeight: FontWeight.w200, key: Key(by + time)),
              SmallCardText(text: time, fontWeight: FontWeight.w200, key: Key(time)),
            ],
          ),
          Text(StringHelper().encodeComments(text)),
          SmallCardText(
            text: '$commentCount comments',
            fontWeight: FontWeight.w300,
            key: Key(commentCount),
          ),
        ],
      ),
    );
  }
}
