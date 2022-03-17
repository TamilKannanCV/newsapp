import 'package:newsapp/models/article.dart';

class News {
  final int totalResults;
  final List<Article> articles;
  News(this.totalResults, this.articles);

  factory News.fromJson(Map<String, dynamic> data) {
    final _totalResults = data['totalResults'];
    final _articles = (data['articles'] as List<dynamic>)
        .map((e) => Article.fromJson(e))
        .toList();
    return News(_totalResults, _articles);
  }
}
