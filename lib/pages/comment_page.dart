import 'package:flutter/material.dart';
import 'package:hackernews/components/story_details/comment_card_stateless.dart';
import 'package:hackernews/components/story_details/header.dart';
import 'package:hackernews/model/comment.dart';
import 'package:hackernews/model/reply.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/network/fetch_data.dart';
import 'package:hackernews/util/string_helper.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key, required this.story}) : super(key: key);

  final Story story;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> with AutomaticKeepAliveClientMixin {
  late Future<List<Comment>> _comments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _comments = FetchData().getComments(widget.story);
  }

  Future<List<Reply>> getRepliesForComment(int index) async {
    List<Comment> listOfAllComments = await _comments;
    List<Reply> repliesFromListOfInts = await FetchData().getRepliesFromListOfInts(listOfAllComments[index].kids);
    return repliesFromListOfInts;
  }

  List<Reply> listOfReplies(int index) {
    List<Reply> replies = [];
    Future<List<Reply>> repliesForComment = getRepliesForComment(index);

    repliesForComment.then((value) => value.forEach((element) {
          print('loop');
          replies.add(element);
        }));

    print(replies.length);

    return replies;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                          commentCount: widget.story.commentIds.length.toString(),
                          time: widget.story.time);
                    } else {
                      return CommentCardStateless(
                        id: comment.data![index].id,
                        by: comment.data![index].by,
                        time: comment.data![index].time,
                        text: StringHelper().encodeComments(comment.data![index].text),
                        replies: getRepliesForComment(index),
                      );
                    }
                  });
            } else if (comment.hasError) {
              return Center(
                child: Text(comment.error.toString()),
              );
            } else {
              return Center(
                  child: CircularProgressIndicator(
                strokeWidth: 1.0,
              ));
            }
          },
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
