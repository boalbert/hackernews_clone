import 'dart:convert';

import 'package:hackernews/model/story.dart';
import 'package:hackernews/network/url_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Util {
  Future<Response> _getStory(int storyId) {
    return http.get(Uri.parse(UrlHelper.urlForStory(storyId)));
  }

  Future<List<Response>> getTopStories(int topStories) async {
    final response = await http.get(Uri.parse(UrlHelper.urlForTopStories()));
    if (response.statusCode == 200) {
      Iterable storyIds = jsonDecode(response.body);
      return Future.wait(storyIds.take(topStories).map((storyId) {
        return _getStory(storyId);
      }));
    } else {
      throw Exception("Unable to fetch data!");
    }
  }

  Future<List<Response>> getCommentsByStoryId(Story story) {
    return Future.wait(story.commentIds.map((commentId) {
      return http.get(Uri.parse(UrlHelper.urlForCommentById(commentId)));
    }));
  }
}
