import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                if (StringHelper().parseBaseUrl(url) != '')
                  Text(
                    StringHelper().parseBaseUrl(url),
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
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
                score + ' points',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
              ),
              Text(
                ' - ',
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
              ),
              Text("$comments comments",
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 11)),
            ],
          )
        ],
      ),
    );
  }
}

class SmallCardText extends StatelessWidget {
  const SmallCardText({
    Key? key,
    required this.text,
    required this.fontWeight,
  }) : super(key: key);

  final String text;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: fontWeight, fontSize: 11),
    );
  }
}
