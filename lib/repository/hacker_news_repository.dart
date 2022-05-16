import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/comment.dart';
import 'package:hackernews/model/story.dart';
import 'package:hackernews/network/hacker_news_api.dart';
import 'package:hackernews/repository/abstract_hacker_news_repository.dart';
import 'package:http/http.dart' as http;

class HttpHackerNewsRepository implements HackerNewRepository {
  final HackerNewsAPI api;
  final http.Client client;

  HttpHackerNewsRepository({required this.api, required this.client});

  @override
  Future<List<Story>> getTopStories() async {
    final response = await client.get(api.topStories());
    switch (response.statusCode) {
      case 200:
        return await _parseStories(response);
      default:
        throw Exception('Could not fetch topStories');
    }
  }

  Future<List<Story>> getNewStories() async {
    final response = await client.get(api.newStories());
    switch (response.statusCode) {
      case 200:
        return await _parseStories(response);
      default:
        throw Exception('Could not fetch topStories');
    }
  }

  @override
  Future<Story> getStory({required int storyId}) async {
    final response = await client.get(api.story(storyId: storyId));
    switch (response.statusCode) {
      case 200:
        return Story.fromJson(jsonDecode(response.body));
      default:
        throw Exception('Could not fetch $storyId');
    }
  }

  Future<List<http.Response>> getCommentsByStoryId(Story story) async {
    return Future.wait(story.commentIds.map((commentId) {
      return http.get(api.comment(commentId: commentId));
    }));
  }

  Future<List<Comment>> getComments(Story story) async {
    final responses = getCommentsByStoryId(story);

    return responses.then((value) => value.map((response) {
          final json = jsonDecode(response.body);
          return Comment.fromJson(json);
        }).toList());
  }

  Future<List<Story>> _parseStories(http.Response response) async {
    List<dynamic> storyIds = jsonDecode(response.body);

    return Future.wait(storyIds.take(30).map((e) => getStory(storyId: e)).toList());
    // return storyFuture;
    // for (int i = 0; i < 50; i++) {
    //   Story story = await getStory(storyId: storyIds[i]);
    //   stories.add(story);
    // }
    // return storyMap;
  }
}

final hackerNewsRepositoryProvider = Provider<HttpHackerNewsRepository>((ref) {
  return HttpHackerNewsRepository(
    api: HackerNewsAPI(),
    client: http.Client(),
  );
});
