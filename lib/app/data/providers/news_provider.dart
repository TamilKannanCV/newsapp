import 'package:get/get.dart';
import 'package:newsapp/app/data/models/article.dart';
import 'package:newsapp/app/data/providers/i_p_data_provider.dart';

class NewsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) {
        final jsonData = map;
        final articles = (jsonData['articles'] as List<dynamic>).map((e) => Article.fromJson(e)).toList();
        return articles;
      }
    };
    httpClient.baseUrl = 'https://corsproxy.io';
  }

  Future<List<Article>> getArticles({int page = 0}) async {
    final response1 = await Get.find<IPDataProvider>().getIPData();
    final response = await get(
      '?https://newsapi.org/v2/top-headlines?country=${response1?.countryCode}&apiKey=c7bd66f8b7b8419d80ecefcac8688122&page=$page',
    );
    return response.body;
  }
}
