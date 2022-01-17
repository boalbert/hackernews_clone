import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackernews/components/story_details/comment_card.dart';
import 'package:hackernews/components/story_details/header.dart';
import 'package:hackernews/model/comment.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/network/fetch_data.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key, required this.story}) : super(key: key);

  final Story story;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late Future<List<Comment>> _comments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _comments = FetchData().getComments(widget.story);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.story.title),
        ),
        body: FutureBuilder<List<Comment>>(
          future: _comments,
          builder: (context, comment) {
            if (comment.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: comment.data!.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Header(
                          url: widget.story.url,
                          title: widget.story.url,
                          by: widget.story.by,
                          points: widget.story.score,
                          commentCount:
                              widget.story.commentIds.length.toString(),
                          time: widget.story.time);
                    } else {
                      return CommentCard(
                        by: comment.data![index].by,
                        text: comment.data![index].text,
                        time: comment.data![index].time,
                      );
                    }
                  });
            } else if (comment.hasError) {
              return Center(
                child: Text(comment.error.toString()),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
