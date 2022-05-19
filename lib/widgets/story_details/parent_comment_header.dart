import 'package:flutter/material.dart';

class ParentCommentHeader extends StatefulWidget {
  final String by;
  final String time;
  bool expanded;

  ParentCommentHeader({
    Key? key,
    required this.by,
    required this.time,
    required this.expanded,
  }) : super(key: key);

  @override
  State<ParentCommentHeader> createState() => _ParentCommentHeaderState();
}

class _ParentCommentHeaderState extends State<ParentCommentHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, top: 8),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.orangeAccent,
            width: 3,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            '${widget.by} - ${widget.time}',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 11),
          ),
          Spacer(),
          Visibility(
            visible: !widget.expanded,
            child: Icon(
              Icons.arrow_drop_down_rounded,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
