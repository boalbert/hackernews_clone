import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/providers/top_articles_provider.dart';
import 'package:hackernews/screens/comments/comment_page.dart';
import 'package:hackernews/widgets/error_message.dart';
import 'package:hackernews/widgets/story/story_card.dart';

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
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => _navigateToShowCommentsPage(context, story[index]),
              child: index == 0
                  ? SizedBox(height: 16)
                  : StoryCard(
                      key: Key('${story[index].id.toString()}_topStories'),
                      title: story[index].title,
                      score: story[index].score,
                      by: story[index].by,
                      url: story[index].url,
                      comments: story[index].commentIds.length,
                      time: story[index].time,
                    ),
            );
          },
        ),
      ),
      error: (e, st) => ErrorMessage(e.toString()),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
