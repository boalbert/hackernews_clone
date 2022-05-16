class HackerNewsAPI {
  static const String _apiBaseUrl = "hacker-news.firebaseio.com";
  static const String _topStoriesPath = "/v0/topstories.json";
  static const String _item = "/v0/item/";

  Uri comment({required int commentId}) {
    return Uri(scheme: "https", host: _apiBaseUrl, path: "$_item$commentId.json");
  }

  Uri topStories() {
    return Uri.parse('https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty');
  }

  Uri story({required int storyId}) {
    return Uri.parse("https://hacker-news.firebaseio.com/v0/item/$storyId.json?print=pretty");
  }

  Uri newStories() {
    return Uri.parse('https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty');
  }
}
