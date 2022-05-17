import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/comment.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/repository/hacker_news_repository.dart';

final topStoriesProvider = FutureProvider<List<Story>>((ref) async {
  return ref.watch(hackerNewsRepositoryProvider).getTopStories();
});
final newStoriesProvider = FutureProvider<List<Story>>((ref) async {
  return ref.watch(hackerNewsRepositoryProvider).getNewStories();
});

final storyProvider = FutureProvider.family<List<Comment>, Story>((ref, story) {
  return ref.watch(hackerNewsRepositoryProvider).getComments(story);
});

final repliesProvider = FutureProvider.family<List<Comment>, Comment>((ref, comment) {
  return ref.watch(hackerNewsRepositoryProvider).getReplies(comment);
});
