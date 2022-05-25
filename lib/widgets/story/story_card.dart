import 'package:flutter/material.dart';
import 'package:hackernews/util/string_helper.dart';
import 'package:hackernews/widgets/small_card_text.dart';
import 'package:url_launcher/url_launcher.dart';

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

  _openUrl() async {
    await launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _openUrl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (StringHelper().parseHost(url) != '')
                Text(
                  StringHelper().parseHost(url),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            SmallCardText(text: by),
            SmallCardText(text: ' - '),
            SmallCardText(text: time),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              '$score points',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              " - $comments comments",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        SizedBox(height: 32)
      ],
    );
  }
}
