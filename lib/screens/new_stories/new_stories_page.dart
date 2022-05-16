import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/providers/top_articles_provider.dart';
import 'package:hackernews/screens/comments/comment_page.dart';
import 'package:hackernews/widgets/story_card.dart';

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
          itemBuilder: (context, i) => InkWell(
                onTap: () => _navigateToShowCommentsPage(context, story[i]),
                child: StoryCard(
                  key: Key(story[i].id.toString()),
                  title: story[i].title,
                  score: story[i].score,
                  by: story[i].by,
                  url: story[i].url,
                  comments: story[i].commentIds.length,
                  time: story[i].time,
                ),
              )),
      error: (e, st) => Center(
        child: Text('Error $e'),
      ),
      loading: () => Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      ),
    );
  }
}
