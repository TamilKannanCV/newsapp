import 'package:flutter/material.dart';
import 'package:newsapp/models/article.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen(this.article, {Key? key}) : super(key: key);
  final Article article;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.article.title.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Text(widget.article.content.toString()),
    );
  }
}
