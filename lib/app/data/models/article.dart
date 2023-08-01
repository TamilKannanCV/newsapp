class Article {
  final String? title;
  final String? description;
  final String? author;
  final String? url;
  final String? imageUrl;
  final String? content;

  Article(
    this.title,
    this.description,
    this.author,
    this.url,
    this.imageUrl,
    this.content,
  );

  factory Article.fromJson(Map<String, dynamic> data) {
    final _title = data['title'] as String?;
    final _description = data['description'] as String?;
    final _author = data['author'] as String?;
    final _url = data['url'] as String?;
    final _imageUrl = data['urlToImage'] as String?;
    final _content = data['content'] as String?;

    return Article(
      _title,
      _description,
      _author,
      _url,
      _imageUrl,
      _content,
    );
  }
}
