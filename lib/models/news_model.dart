class SourceModel {
  final String? id;
  final String name;

  SourceModel({this.id, required this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ArticleModel {
  SourceModel source;
  String? author;
  String title;
  String description;
  String url;
  String? urlToImage;
  String publishedAt;
  String content;

  ArticleModel(
      {required this.source,
      this.author,
      required this.title,
      required this.description,
      required this.url,
      this.urlToImage,
      required this.publishedAt,
      required this.content});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
        source: SourceModel.fromJson(json['source']),
        author: json['author'],
        title: json['title'] as String,
        description: json['description'] as String,
        url: json['url'] as String,
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'] as String,
        content: json['content'] as String);
  }
}
