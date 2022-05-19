import 'package:flutter/material.dart';
import 'package:hackernews/util/string_helper.dart';

class ParentCommentText extends StatefulWidget {
  final String text;

  const ParentCommentText({Key? key, required this.text}) : super(key: key);

  @override
  ParentCommentTextState createState() => ParentCommentTextState();
}

class ParentCommentTextState extends State<ParentCommentText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, bottom: 8),
      margin: EdgeInsets.only(bottom: 8),
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
          SizedBox(
            height: 8,
          ),
          Text(StringHelper().encodeComments(widget.text)),
        ],
      ),
    );
  }
}
