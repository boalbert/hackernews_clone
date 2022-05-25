import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/providers/top_articles_provider.dart';
import 'package:hackernews/screens/comments/comment_page.dart';
import 'package:hackernews/widgets/error_message.dart';
import 'package:hackernews/widgets/story/story_card.dart';

class NewStoriesPage extends ConsumerStatefulWidget {
  const NewStoriesPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TopArticleListState();
}

void _navigateToShowCommentsPage(BuildContext context, Story story) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CommentPage(story),
    ),
  );
}

class _TopArticleListState extends ConsumerState<NewStoriesPage> {
  @override
  Widget build(BuildContext context) {
    final stories = ref.watch(newStoriesProvider);
    return stories.when(
      data: (story) => ListView.builder(
        itemCount: story.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => _navigateToShowCommentsPage(context, story[index]),
          child: index == 0
              ? SizedBox(height: 16)
              : StoryCard(
                  title: story[index].title,
                  score: story[index].score,
                  by: story[index].by,
                  url: story[index].url,
                  comments: story[index].commentIds.length,
                  time: story[index].time,
                ),
        ),
      ),
      error: (e, st) => ErrorMessage(e.toString()),
      loading: () => Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      ),
    );
  }
}
