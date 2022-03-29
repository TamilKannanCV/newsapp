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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News App",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: ApiService().fetchNews(),
        builder: (context, AsyncSnapshot<List<Article>?> snapshot) {
          if (snapshot.data == null) {
            return const Center(child: Text("No data fetched"));
          }
          final data = snapshot.data;
          return ListView.builder(
            itemBuilder: ((context, index) => ListItem(data![index])),
            itemCount: data?.length,
          );
        },
      ),
    );
  }
}
