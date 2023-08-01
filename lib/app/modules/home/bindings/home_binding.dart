import 'package:get/get.dart';
import 'package:newsapp/app/data/providers/i_p_data_provider.dart';
import 'package:newsapp/app/data/providers/news_provider.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<IPDataProvider>(() => IPDataProvider());
    Get.lazyPut<NewsProvider>(() => NewsProvider());
  }
}
