import 'package:get/get.dart';
import 'package:newsapp/app/data/models/article.dart';
import 'package:newsapp/app/data/providers/news_provider.dart';

class HomeController extends GetxController with StateMixin<List<Article>> {
  @override
  void onInit() {
    super.onInit();
    Get.find<NewsProvider>().getArticles().then(
      (articles) {
        if (articles.isEmpty) {
          change(articles, status: RxStatus.empty());
        } else {
          change(articles, status: RxStatus.success());
        }
      },
      onError: (err) {
        change(null, status: RxStatus.error());
      },
    );
  }

  @override
  void onReady() {}

  @override
  void onClose() {}
}
