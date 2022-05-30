import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/comment.dart';
import 'package:hackernews/model/comment/item.dart';
import 'package:hackernews/model/comment/real_comment.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/repository/hacker_news_repository.dart';

final topStoriesProvider = FutureProvider<List<Story>>((ref) async {
  return ref.watch(hackerNewsRepositoryProvider).getTopStories();
});

final newStoriesProvider = FutureProvider<List<Story>>((ref) async {
  return ref.watch(hackerNewsRepositoryProvider).getNewStories();
});

final commentsProvider = FutureProvider.family<Item, int>((ref, int itemId) {
  return ref.watch(hackerNewsRepositoryProvider).getComments2(itemId);
});

final commentCountProvider = FutureProvider.family<CommentCount, int>((ref, int itemId) async {
  return ref.watch(hackerNewsRepositoryProvider).getCommentCount(itemId);
});

final singleStoryProvider = FutureProvider.family<List<Comment>, Story>((ref, story) {
  return ref.watch(hackerNewsRepositoryProvider).getComments(story);
});

final repliesProvider = FutureProvider.family<List<Comment>, Comment>((ref, comment) {
  return ref.watch(hackerNewsRepositoryProvider).getReplies(comment);
});

final storyProvider = FutureProvider.family<Story, int>((ref, storyId) {
  return ref.watch(hackerNewsRepositoryProvider).getStory(storyId: storyId);
});
