import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/search/hits.dart';
import 'package:hackernews/repository/hacker_news_repository.dart';

final searchStoryByRelevanceProvider = FutureProvider.autoDispose.family<Hits, String>((ref, question) async {
  return ref.watch(hackerNewsRepositoryProvider).searchByRelevance(question);
});
