class Article {
  final String? title, description, url, imageUrl;
  Article(this.title, this.description, this.url, this.imageUrl);

  factory Article.fromJson(Map<String, dynamic> data) {
    final _title = data['title'] as String?;
    final _desc = data['description'] as String?;
    final _url = data['url'] as String?;
    final _imageUrl = data['urlToImage'] as String?;
    return Article(_title, _desc, _url, _imageUrl);
  }
}
