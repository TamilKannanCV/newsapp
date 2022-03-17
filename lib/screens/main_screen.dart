import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/news.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: http.get(Uri.parse(
            "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=c7bd66f8b7b8419d80ecefcac8688122")),
        builder: (context, AsyncSnapshot<http.Response> snapshot) {
          if (snapshot.hasData) {
            final data = json.decode(snapshot.data!.body);
            final news = News.fromJson(data);
            return ListView.builder(
                itemCount: news.articles.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      launch(news.articles[index].url.toString());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.network(
                            news.articles[index].imageUrl.toString(),
                            height: 50.0,
                            width: 50.0,
                            errorBuilder: (context, obj, trace) {
                              return SizedBox(
                                  height: 50.0,
                                  width: 50.0,
                                  child: Placeholder());
                            },
                          ),
                          Text(news.articles[index].title.toString())
                        ],
                      ),
                    ),
                  );
                });
          }
          if (snapshot.hasError) {}
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
