import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/providers/top_articles_provider.dart';
import 'package:hackernews/util/string_helper.dart';
import 'package:hackernews/widgets/story_details/comment_card.dart';
import 'package:hackernews/widgets/story_details/story_header.dart';

class CommentPage extends ConsumerWidget {
  final Story story;

  const CommentPage(
    this.story, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue comments = ref.watch(storyProvider(story));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
      ),
      body: comments.when(
        data: (data) => Column(
          children: [
            StoryHeader(
              url: story.url,
              title: story.title,
              by: story.by,
              points: story.score,
              commentCount: story.commentIds.length.toString(),
              time: story.time,
              text: StringHelper().encodeComments(story.text),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return CommentCard(
                      data[index],
                      key: Key(data[index].id.toString()),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ),
              ),
            ),
          ],
        ),
        error: (e, st) => Text('Error $e'),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
