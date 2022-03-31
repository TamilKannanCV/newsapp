import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newsapp/models/article.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart' as win;

class NewsScreen extends StatefulWidget {
  const NewsScreen(this.article, {Key? key}) : super(key: key);
  final Article article;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final _winWebController = win.WebviewController();
  @override
  void initState() {
    super.initState();
    if (Platform.isWindows) {
      initPlatformView();
    }
  }

  Future<void> initPlatformView() async {
    await _winWebController.initialize();
    await _winWebController.loadUrl("${widget.article.url}");

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.article.title.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: "${widget.article.title}",
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          widget.article.imageUrl ?? '',
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
                      "${widget.article.description}",
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            preferredSize: const Size(double.infinity, 100.0)),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            launch("${widget.article.url}");
          },
          child: Text(
            "Source: ${widget.article.url}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: Container(
        child: Platform.isWindows
            ? _winWebController.value.isInitialized == true
                ? StreamBuilder(
                    stream: _winWebController.loadingState,
                    builder:
                        ((context, AsyncSnapshot<win.LoadingState> snapshot) {
                      if (snapshot.data == win.LoadingState.loading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return win.Webview(_winWebController);
                    }),
                  )
                : const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
            : WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: "${widget.article.url}",
              ),
      ),
    );
  }
}
