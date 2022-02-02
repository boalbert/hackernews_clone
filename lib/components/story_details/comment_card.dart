import 'package:flutter/material.dart';
import 'package:hackernews/model/reply.dart';
import 'package:hackernews/network/fetch_data.dart';

import '../small_card_text.dart';

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
  }

  void _toggleComment() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reply>>(
        future: replies,
        builder: (context, reply) {
          if (reply.hasData && reply.connectionState == ConnectionState.done) {
            return Container(
              padding: EdgeInsets.only(bottom: 5.0, top: 10, left: 10, right: 10),
              child: Column(
                children: [
                  Row(children: [
                    SmallCardText(
                      text: widget.by,
                      fontWeight: FontWeight.w300,
                      key: Key(widget.by),
                    ),
                    SmallCardText(
                      text: ' - ',
                      fontWeight: FontWeight.w200,
                      key: Key(widget.by + widget.time),
                    ),
                    SmallCardText(
                      text: widget.time,
                      fontWeight: FontWeight.w200,
                      key: Key(widget.time),
                    ),
                  ]),
                  Column(
                    children: [
                      Text(widget.text),
                      ListView.builder(
                        cacheExtent: 3000000,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(width: 2.0, color: Colors.orange),
                              ),
                            ),
                            padding: EdgeInsets.only(left: 15, top: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SmallCardText(text: reply.data![index].by, fontWeight: FontWeight.w300, key: Key(reply.data![index].by)),
                                    SmallCardText(
                                      text: ' - ',
                                      fontWeight: FontWeight.w200,
                                      key: Key(reply.data![index].by + reply.data![index].time),
                                    ),
                                    SmallCardText(
                                      text: reply.data![index].time,
                                      fontWeight: FontWeight.w200,
                                      key: Key(reply.data![index].time),
                                    ),
                                  ],
                                ),
                                Text(reply.data![index].text),
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: reply.data!.length,
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (reply.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (reply.connectionState == ConnectionState.active) {
            return CircularProgressIndicator();
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
