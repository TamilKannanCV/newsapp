import 'package:flutter/material.dart';
import 'package:newsapp/app/data/models/article.dart';

class ListItem extends StatefulWidget {
  const ListItem(this.article, {Key? key, this.onTap}) : super(key: key);
  final Article article;
  final VoidCallback? onTap;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> with TickerProviderStateMixin {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..scale(1.1, 1.1);
    Matrix4 transform = _isHover ? hoveredTransform : Matrix4.identity();

    return Material(
      child: Container(
        width: (MediaQuery.of(context).size.width < 500.0) ? 400.0 : 300.0,
        height: 250.0,
        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(15.0)),
        child: MouseRegion(
          onEnter: (_) {
            onMouseEvent(true);
          },
          onExit: (_) {
            onMouseEvent(false);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(15.0),
              onTap: widget.onTap,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      foregroundDecoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                          ],
                        ),
                      ),
                      child: AnimatedContainer(
                        transform: transform,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear,
                        child: Image.network(
                          "https://corsproxy.io?${widget.article.imageUrl}",
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
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.article.title.toString(),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onMouseEvent(bool isHovered) {
    setState(() {
      _isHover = isHovered;
    });
  }
}
