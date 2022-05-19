import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/comment.dart';
import 'package:hackernews/providers/top_articles_provider.dart';
import 'package:hackernews/widgets/error_message.dart';
import 'package:hackernews/widgets/story_details/parent_comment_header.dart';
import 'package:hackernews/widgets/story_details/parent_comment_text.dart';

class CommentCard extends ConsumerStatefulWidget {
  final Comment comment;
  bool expanded;

  CommentCard(
    this.comment, {
    Key? key,
    this.expanded = true,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ConsumerCardState();
}

class _ConsumerCardState extends ConsumerState<CommentCard> {
  @override
  Widget build(BuildContext context) {
    final replies = ref.watch(repliesProvider(widget.comment));
    return replies.when(
      data: (data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                widget.expanded = !widget.expanded;
              });
            },
            child: ParentCommentHeader(
              key: Key(widget.comment.id.toString()),
              by: widget.comment.by,
              time: widget.comment.time,
              expanded: widget.expanded,
            ),
          ),
          Visibility(
            visible: widget.expanded,
            child: Column(
              children: [
                ParentCommentText(
                  text: widget.comment.text,
                ),
                ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: CommentCard(
                        data[index],
                        key: Key(data[index].id.toString()),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      error: (e, st) => ErrorMessage(e.toString()),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
