import 'package:flutter/material.dart';

class UnfocusArea extends StatelessWidget {
  const UnfocusArea({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Makes clickable on everywhere even if the widget is not opaque
      behavior: HitTestBehavior.opaque,
      // Magic happens here
      onTap: () {
        try {
          FocusScope.of(context).unfocus();
        } catch (e) {}
      },
      child: child,
    );
  }
}
