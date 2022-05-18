import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/comment.dart';
import 'package:hackernews/providers/top_articles_provider.dart';
import 'package:hackernews/widgets/error_message.dart';
import 'package:hackernews/widgets/story_details/parent_comment.dart';

class CommentCard extends ConsumerWidget {
  final Comment comment;

  const CommentCard(this.comment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final replies = ref.watch(repliesProvider(comment));
    return replies.when(
      data: (data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ParentComment(
            by: comment.by,
            time: comment.time,
            text: comment.text,
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
      error: (e, st) => ErrorMessage(e.toString()),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
