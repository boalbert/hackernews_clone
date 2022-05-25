import 'package:hackernews/model/search/hits_story.dart';

class Hits {
  final List<HitsStory>? searchHits;
  final int? nbHits;
  final int? page;
  final int? nbPages;
  final int? processingTimeMS;

  Hits({
    this.searchHits,
    this.nbHits,
    this.page,
    this.nbPages,
    this.processingTimeMS,
  });

  factory Hits.fromJson(Map<String, dynamic> json) => Hits(
        searchHits: List<HitsStory>.from(json["hits"].map((x) => HitsStory.fromJson(x))),
        nbHits: json["nbHits"],
        page: json["page"],
        nbPages: json["nbPages"],
        processingTimeMS: json["processingTimeMS"],
      );

  @override
  String toString() {
    return 'Hits{searchHits: $searchHits, nbHits: $nbHits, page: $page, nbPages: $nbPages}';
  }
}
