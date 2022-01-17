import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../story_card.dart';

class CommentCard extends StatefulWidget {
  final String by;
  final String time;
  final String text;

  const CommentCard({
    Key? key,
    required this.by,
    required this.time,
    required this.text,
  }) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool _expanded = true;
  
  void _toggleComment() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleComment,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: [
                SmallCardText(text: widget.by, fontWeight: FontWeight.w300),
                SmallCardText(text: ' - ', fontWeight: FontWeight.w200),
                SmallCardText(text: widget.time, fontWeight: FontWeight.w200),
              ],
            ),
          ),
          Visibility(visible: _expanded, child: Text(widget.text)),
          Divider(),
        ]),
      ),
    );
  }
}
