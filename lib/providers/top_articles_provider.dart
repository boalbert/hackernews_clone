import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/comment.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/network/hacker_news_api.dart';
import 'package:hackernews/repository/hacker_news_repository.dart';
import 'package:http/http.dart' as http;

final hackerNewsRepositoryProvider = Provider<HttpHackerNewsRepository>((ref) {
  return HttpHackerNewsRepository(api: HackerNewsAPI(), client: http.Client());
});

final topStoriesProvider = FutureProvider<List<Story>>((ref) async {
  return HttpHackerNewsRepository(client: http.Client(), api: HackerNewsAPI()).getTopStories();
});

final newStoriesProvider = FutureProvider<List<Story>>((ref) async {
  return HttpHackerNewsRepository(client: http.Client(), api: HackerNewsAPI()).getNewStories();
});

final storyProvider = FutureProvider.family<List<Comment>, Story>((ref, story) {
  return HttpHackerNewsRepository(client: http.Client(), api: HackerNewsAPI()).getComments(story);
});
