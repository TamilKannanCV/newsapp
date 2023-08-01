import 'package:error_message/error_message.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:newsapp/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';
import 'widgets/list_item.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
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
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("If you have any queries to reach us at"),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
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
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      )
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.contact_support)),
        ],
      ),
      body: controller.obx(
        (state) {
          return SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 10.0,
                runSpacing: 10.0,
                children: state!
                    .where((e) => e.imageUrl != null)
                    .map(
                      (e) => Hero(
                        tag: "${e.title}",
                        child: ListItem(
                          e,
                          onTap: () {
                            Get.toNamed(Routes.NEWS, arguments: e);
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
        onEmpty: const Center(
          child: ErrorMessage(
            icon: Icon(Icons.list),
            title: "No news found",
          ),
        ),
        onError: (error) {
          return const Center(
              child: ErrorMessage(
            title: "Unable to fetch news",
            icon: Icon(Icons.error),
          ));
        },
      ),
    );
  }
}
