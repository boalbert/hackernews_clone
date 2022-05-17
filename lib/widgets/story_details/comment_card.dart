import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/comment.dart';
import 'package:hackernews/providers/top_articles_provider.dart';
import 'package:hackernews/widgets/error_message.dart';
import 'package:hackernews/widgets/small_card_text.dart';

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
          SmallCardText(
            key: Key(comment.by + comment.time),
            fontWeight: FontWeight.normal,
            text: '${comment.by} - ${comment.time}',
          ),
          SizedBox(
            height: 8,
          ),
          Text(comment.text),
          ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(left: 8, top: 16),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Colors.orangeAccent,
                      width: 3,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: CommentCard(
                    data[index],
                    key: Key(data[index].id.toString()),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      error: (e, st) => ErrorMessage(e.toString()),
      loading: () => CircularProgressIndicator(),
    );
  }
}
