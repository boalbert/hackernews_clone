import 'dart:convert';

import 'package:hackernews/constants/constants.dart' as constants;
import 'package:hackernews/model/story.dart';
import 'package:hackernews/network/url_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FetchData {
  Future<Response> _getStoryDetails(int storyId) {
    return http.get(Uri.parse(UrlHelper.urlForStory(storyId)));
  }

  Future<List<Response>> getTopStories(int topStories) async {
    final response = await http.get(Uri.parse(UrlHelper.urlForTopStories()));
    if (response.statusCode == 200) {
      Iterable storyIds = jsonDecode(response.body);
      return Future.wait(storyIds
          .skip(topStories)
          .take(constants.Numbers.storiesToLoad)
          .map((storyId) {
        return _getStoryDetails(storyId);
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

  Future<List<Story>> loadStories(int storiesToLoad) async {
    final responses = await getTopStories(storiesToLoad);
    return responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJson(json);
    }).toList();
  }
}
