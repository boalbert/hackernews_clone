import 'package:flutter_test/flutter_test.dart';
import 'package:hackernews/model/search/hits.dart';
import 'package:hackernews/model/search/hits_story.dart';
import 'package:hackernews/network/hacker_news_api.dart';
import 'package:hackernews/repository/hacker_news_repository.dart';
import 'package:http/http.dart';

void main() {
  test('Search returns list of Stories', () async {
    Hits searchHits = await HttpHackerNewsRepository(api: HackerNewsAPI(), client: Client()).searchByRelevance('Flutter');

    print(searchHits);
    print(searchHits.searchHits);
    assert(searchHits.searchHits is List<HitsStory>);
  });
}
