import 'package:flutter/material.dart';
import 'package:hackernews/util/string_helper.dart';
import 'package:hackernews/widgets/small_card_text.dart';

class ParentComment extends StatelessWidget {
  final String by;
  final String time;
  final String text;

  const ParentComment({
    Key? key,
    required this.by,
    required this.time,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.orangeAccent,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmallCardText(
            key: Key('$by $time'),
            fontWeight: FontWeight.normal,
            text: '$by - $time',
          ),
          SizedBox(
            height: 8,
          ),
          Text(StringHelper().encodeComments(text)),
        ],
      ),
    );
  }
}
