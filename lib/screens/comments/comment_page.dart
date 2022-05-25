import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/providers/top_articles_provider.dart';
import 'package:hackernews/widgets/comment/comment_card.dart';
import 'package:hackernews/widgets/error_message.dart';

class CommentPage extends ConsumerWidget {
  final Story story;

  const CommentPage(
    this.story, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue comments = ref.watch(singleStoryProvider(story));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          story.title,
        ),
        toolbarHeight: 64,
      ),
      body: comments.when(
        data: (data) => RefreshIndicator(
          onRefresh: () async {
            ref.refresh(singleStoryProvider(story));
            return await ref.read(singleStoryProvider(story).future);
          },
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return CommentCard(
                data[index],
                key: Key(
                  data[index].id.toString(),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        ),
        error: (e, st) => ErrorMessage(e.toString()),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
