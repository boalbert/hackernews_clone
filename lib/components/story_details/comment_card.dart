import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/model/reply.dart';
import 'package:hackernews/network/fetch_data.dart';

import '../story_card.dart';

class CommentCard extends StatefulWidget {
  final int id;
  final String by;
  final String time;
  final String text;
  final List<int> kids;

  const CommentCard({
    Key? key,
    required this.id,
    required this.by,
    required this.time,
    required this.text,
    required this.kids,
  }) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool _expanded = true;
  late Future<List<Reply>> replies;

  @override
  void initState() {
    super.initState();
    replies = FetchData().getRepliesFromListOfInts(widget.kids);
    // replies = FetchData().getReplies(widget.id);
  }

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
          Visibility(
            visible: _expanded,
            child: Column(
              children: [
                Text(widget.text),
                Container(
                  child: FutureBuilder<List<Reply>>(
                    future: replies,
                    builder: (context, reply) {
                      if (reply.hasData &&
                          reply.connectionState == ConnectionState.done) {
                        return ListView.separated(
                          cacheExtent: 3000.0,
                          shrinkWrap: true,
                          itemCount: reply.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(reply.data![index].text));
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(),
        ]),
      ),
    );
  }
}
