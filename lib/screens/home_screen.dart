import 'dart:developer';
import 'dart:io';

import 'package:error_message/error_message.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/article.dart';
import 'package:newsapp/services/api_service.dart';
import 'package:newsapp/widgets/list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        // log("message");
        // ApiService.instance.fetchNews();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NewsApp"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Contact Us"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("If you have any queries to reach us at"),
                        const SizedBox(height: 10.0),
                        Row(
                          children: const [
                            Icon(
                              Icons.mail_outline,
                              size: 20.0,
                            ),
                            SizedBox(width: 5.0),
                            Text("tamilkannan.contact@gmail.com"),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("OK"))
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.contact_support)),
        ],
      ),
      body: FutureBuilder(
        future: ApiService.instance.fetchNews(),
        builder: (context, AsyncSnapshot<List<Article>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: ErrorMessage(
              title: "Unable to fetch news",
              icon: Icon(Icons.error),
            ));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          final data = snapshot.data;
          return SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 10.0,
                runSpacing: 10.0,
                children: data!
                    .where((e) => e.imageUrl != null)
                    .map(
                      (e) => Hero(tag: "${e.title}", child: ListItem(e)),
                    )
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
