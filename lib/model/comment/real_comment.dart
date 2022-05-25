class CommentCount {
  final int numberOfComments;

  CommentCount(this.numberOfComments);

  factory CommentCount.fromJson(Map<String, dynamic> json) => CommentCount(json['nbHits']);
}
