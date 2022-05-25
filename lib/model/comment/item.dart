class Item {
  int id;
  String createdAt;
  String author;
  String? title;
  String? url;
  String? text;
  int points;
  int? parentId;
  List<ItemChild>? children;

  Item(this.id, this.createdAt, this.author, this.title, this.url, this.text, this.points, this.parentId, this.children);

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        json['id'],
        json['created_at'],
        json['author'],
        json['title'],
        json['url'],
        json['text'],
        json['points'],
        json['parent_id'],
        List<ItemChild>.from(json["children"].map((x) => ItemChild.fromJson(x))),
      );

  @override
  String toString() {
    return 'Item{id: $id, createdAt: $createdAt, author: $author, title: $title, url: $url, text: $text, points: $points, parentId: $parentId, children: $children}';
  }
}

class ItemChild {
  int id;
  String createdAt;
  String? author;
  String? text;
  int? points;
  int? parentId;
  List<ItemChild>? children;

  ItemChild(this.id, this.createdAt, this.author, this.text, this.points, this.parentId, this.children);

  factory ItemChild.fromJson(Map<String, dynamic> json) => ItemChild(
        json['id'],
        json['created_at'],
        json['author'],
        json['text'],
        json['points'],
        json['parent_id'],
        List<ItemChild>.from(json["children"].map((x) => ItemChild.fromJson(x))),
      );

  @override
  String toString() {
    return 'ItemChild{id: $id, createdAt: $createdAt, author: $author, text: $text, points: $points, parentId: $parentId, children: $children}';
  }
}
