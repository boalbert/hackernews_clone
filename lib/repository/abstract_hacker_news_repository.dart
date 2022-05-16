import 'package:hackernews/model/story.dart';

abstract class HackerNewRepository {
  Future<List<Story>> getTopStories();

  Future<Story> getStory({required int storyId});
}
