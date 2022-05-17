import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/providers/top_articles_provider.dart';
import 'package:hackernews/screens/comments/comment_page.dart';
import 'package:hackernews/widgets/story_card.dart';

class TopStoriesPage extends ConsumerStatefulWidget {
  const TopStoriesPage({
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

class _TopArticleListState extends ConsumerState<TopStoriesPage> {
  @override
  Widget build(BuildContext context) {
    var stories = ref.watch(topStoriesProvider);
    return stories.when(
      data: (story) => RefreshIndicator(
        onRefresh: () async {
          ref.refresh(topStoriesProvider);
          return await ref.read(topStoriesProvider.future);
        },
        child: ListView.builder(
            itemCount: story.length,
            itemBuilder: (context, i) => InkWell(
                  onTap: () => _navigateToShowCommentsPage(context, story[i]),
                  child: StoryCard(
                    title: story[i].title,
                    score: story[i].score,
                    by: story[i].by,
                    url: story[i].url,
                    comments: story[i].commentIds.length,
                    time: story[i].time,
                  ),
                )),
      ),
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
