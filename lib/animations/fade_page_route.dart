import 'package:flutter/material.dart';

class FadePageRoute extends PageRouteBuilder {
  FadePageRoute(Widget child)
      : super(
          pageBuilder: (context, animation1, animation2) => child,
          reverseTransitionDuration: const Duration(milliseconds: 500),
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(
              opacity: animation1,
              child: child,
            );
          },
        );
}
