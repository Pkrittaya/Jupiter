import 'package:flutter/material.dart';

class DashLineVertical extends StatelessWidget {
  const DashLineVertical({
    super.key,
    required this.height,
    required this.color,
  });

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // double boxHeight = constraints.maxWidth;
        final dashCount = (height / 4.73).round();
        return Column(
          children: List.generate(
              dashCount,
              (ii) => Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: Icon(
                      Icons.circle,
                      color: color,
                      size: 3,
                    ),
                  )),
        );
      },
    );
  }
}
