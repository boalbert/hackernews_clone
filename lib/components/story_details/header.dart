import 'package:flutter/cupertino.dart';
import 'package:hackernews/util/string_helper.dart';

import '../small_card_text.dart';

class Header extends StatelessWidget {
  final String url;
  final String title;
  final String by;
  final String points;
  final String commentCount;
  final String time;

  const Header({
    Key? key,
    required this.url,
    required this.title,
    required this.by,
    required this.points,
    required this.commentCount,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringHelper().parseHost(url),
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Row(
              children: [
                SmallCardText(
                  text: by,
                  fontWeight: FontWeight.w300,
                  key: Key(by),
                ),
                SmallCardText(
                    text: ' - ',
                    fontWeight: FontWeight.w200,
                    key: Key(by + time)),
                SmallCardText(
                    text: time, fontWeight: FontWeight.w200, key: Key(time)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
