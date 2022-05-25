import 'package:flutter/material.dart';
import 'package:hackernews/util/string_helper.dart';
import 'package:hackernews/widgets/small_card_text.dart';

class StoryCard extends StatelessWidget {
  StoryCard({
    Key? key,
    required this.title,
    required this.score,
    required this.by,
    required this.url,
    required this.comments,
    required this.time,
  }) : super(key: key);

  final String title;
  final String score;
  final String by;
  final String url;
  final int comments;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (StringHelper().parseHost(url) != '')
              Text(
                StringHelper().parseHost(url),
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
              ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            SmallCardText(text: by, fontWeight: FontWeight.w300),
            SmallCardText(text: ' - ', fontWeight: FontWeight.w200),
            SmallCardText(text: time, fontWeight: FontWeight.w200),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
        ),
        Row(
          children: [
            Text(
              '$score points',
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 12,
              ),
            ),
            Text(
              " - $comments comments",
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 11),
            ),
          ],
        ),
        SizedBox(height: 16)
      ],
    );
  }
}
