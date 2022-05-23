class HitsStory {
  final String? createdAt;
  final String? title;
  final String? url;
  final String? author;
  final int? points;
  final String? storyText;
  final int? numberOfComments;
  final int? storyId;
  final String? storyTitle;
  final String? storyUrl;
  final int? parentId;

  HitsStory(
    this.createdAt,
    this.title,
    this.url,
    this.author,
    this.points,
    this.storyText,
    this.numberOfComments,
    this.storyId,
    this.storyTitle,
    this.storyUrl,
    this.parentId,
  );

  factory HitsStory.fromJson(Map<String, dynamic> json) {
    return HitsStory(
      json['created_at'],
      json['title'],
      json['url'],
      json['author'],
      json['points'],
      json['story_text'],
      json['num_comments'],
      json['story_id'],
      json['story_title'],
      json['story_url'],
      json['parent_id'],
    );
  }

  @override
  String toString() {
    return 'HitsStory{createdAt: $createdAt, title: $title, url: $url, author: $author, points: $points, storyText: $storyText, numberOfComments: $numberOfComments, storyId: $storyId, storyTitle: $storyTitle, storyUrl: $storyUrl, parentId: $parentId}';
  }
}
