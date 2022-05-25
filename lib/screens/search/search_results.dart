import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackernews/model/search/hits_story.dart';
import 'package:hackernews/widgets/story/story_card.dart';

import 'number_of_results.dart';

class SearchResult extends ConsumerWidget {
  final int numberOfHits;
  final int processingTimeMS;
  final List<HitsStory> searchHits;

  const SearchResult(
    this.numberOfHits,
    this.processingTimeMS,
    this.searchHits, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NumberOfResults(searchHits.length, processingTimeMS),
        Divider(indent: 16, endIndent: 16),
        Flexible(
          fit: FlexFit.loose,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: searchHits.length,
            itemBuilder: (context, index) {
              return StoryCard(
                key: Key('${searchHits[index].createdAt.toString()} - ${searchHits[index].storyId}'),
                url: searchHits[index].url ?? 'url null',
                title: searchHits[index].storyTitle ?? searchHits[index].title!,
                by: searchHits[index].author!,
                time: searchHits[index].createdAt!,
                score: searchHits[index].points.toString() == 'null' ? '0' : searchHits[index].points.toString(),
                comments: searchHits[index].numberOfComments ?? 0,
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        ),
      ],
    );
  }
}
