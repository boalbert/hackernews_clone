import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/model/reply.dart';

import '../small_card_text.dart';

class CommentCardStateless extends StatelessWidget {
  final int id;
  final String by;
  final String time;
  final String text;
  final Future<List<Reply>> replies;

  const CommentCardStateless(
      {Key? key,
      required this.replies,
      required this.id,
      required this.by,
      required this.time,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reply>>(
        future: replies,
        builder: (context, reply) {
          if (reply.hasData && reply.connectionState == ConnectionState.done) {
            return Container(
              padding:
                  EdgeInsets.only(bottom: 5.0, top: 10, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    SmallCardText(
                        key: Key(by + time),
                        text: by,
                        fontWeight: FontWeight.w300),
                    SmallCardText(
                        key: Key(text),
                        text: ' - ',
                        fontWeight: FontWeight.w200),
                    SmallCardText(
                        key: Key(time + by),
                        text: time,
                        fontWeight: FontWeight.w200),
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(text, key: Key(text)),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        cacheExtent: 3000000,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    width: 2.0, color: Colors.orange),
                              ),
                            ),
                            padding: EdgeInsets.only(left: 15, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SmallCardText(
                                        key: Key(reply.data![index].by),
                                        text: reply.data![index].by,
                                        fontWeight: FontWeight.w300),
                                    SmallCardText(
                                        key: Key(reply.data![index].text),
                                        text: ' - ',
                                        fontWeight: FontWeight.w200),
                                    SmallCardText(
                                        key: Key(reply.data![index].time),
                                        text: reply.data![index].time,
                                        fontWeight: FontWeight.w200),
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
            return Center(child: CircularProgressIndicator());
          } else if (reply.connectionState == ConnectionState.active) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
