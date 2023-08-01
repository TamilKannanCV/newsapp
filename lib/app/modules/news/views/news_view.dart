import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:newsapp/app/data/models/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/news_controller.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final article = Get.arguments as Article;
    final controller = WebViewController()..loadRequest(Uri.parse("${article.url}"));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 100.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: "${article.title}",
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(15.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          "https://corsproxy.io/?${article.imageUrl}",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Text("Preview not available"),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Flexible(
                    child: Text(
                      "${article.description}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            launchUrl(Uri.parse("${article.url}"));
          },
          child: Text(
            "Source: ${article.url}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
