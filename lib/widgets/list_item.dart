import 'dart:html';

import 'package:flutter/material.dart';
import 'package:newsapp/models/article.dart';
import 'package:newsapp/screens/news_screen.dart';

class ListItem extends StatelessWidget {
  const ListItem(this.article, {Key? key}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return NewsScreen(article);
          })));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  article.imageUrl!,
                  errorBuilder: (context, error, stackTrace) {
                    return Placeholder();
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              Text(article.author.toString()),
              const SizedBox(height: 8.0),
              Text(article.title.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
