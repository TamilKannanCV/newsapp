import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:newsapp/models/article.dart';

class ApiService {
  final String endPoint =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a4d2069a1ecf478f8a9ea881afa7d9a1";

  Future<List<Article>?> fetchNews() async {
    final response = await http.get(Uri.parse(endPoint));
    if (response.statusCode != 404) {
      final data = response.body;
      final jsonData = json.decode(data) as Map<String, dynamic>;
      final articles = (jsonData['articles'] as List<dynamic>)
          .map((e) => Article.fromJson(e))
          .toList();
      return articles;
    }
    return null;
  }
}
