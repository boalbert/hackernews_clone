import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/comment.dart';
import 'package:hackernews/widgets/small_card_text.dart';

class CommentCard extends ConsumerWidget {
  final Comment comment;

  const CommentCard(this.comment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
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
        Text(comment.text)
      ],
    );
  }
}
