import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:newsapp/models/article.dart';
import 'package:newsapp/models/ip_data.dart';

class ApiService {
  ApiService._();
  static final _instance = ApiService._();
  static ApiService get instance => _instance;
  int page = 0;

  final String apiKey = "a4d2069a1ecf478f8a9ea881afa7d9a1";
  final String endPoint =
      "https://newsapi.org/v2/top-headlines?country=<country>&page=<page>&apiKey=<key>";

  Future<List<Article>?> fetchNews({int page = 0}) async {
    final client = http.Client();
    http.Response response =
        await client.get(Uri.parse("http://ip-api.com/json"));
    final IpData ipData = IpData.fromJson(response.body);
    final _endPoint = endPoint
        .replaceAll('<country>', "${ipData.countryCode}")
        .replaceAll('<page>', "$page")
        .replaceAll('<key>', apiKey);
    log(_endPoint);
    response = await client.get(Uri.parse(_endPoint));
    if (response.statusCode != 404) {
      final data = response.body;
      log(data);
      final jsonData = json.decode(data) as Map<String, dynamic>;
      final articles = (jsonData['articles'] as List<dynamic>)
          .map((e) => Article.fromJson(e))
          .toList();
      return articles;
    }
    return null;
  }
}
