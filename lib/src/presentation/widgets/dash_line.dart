import 'package:flutter/material.dart';

class DashLine extends StatelessWidget {
  const DashLine({
    super.key,
    required this.width,
    required this.color,
  });

  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      child: Flex(
        direction: Axis.vertical,
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final boxWidth = constraints.constrainWidth();
              final double dashHeight = 1;
              final dashCount = (boxWidth / (2 * 5)).floor();
              return Flex(
                children: List.generate(dashCount, (_) {
                  return SizedBox(
                    width: 5,
                    height: dashHeight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: color),
                    ),
                  );
                }),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
              );
            },
          )
        ],
      ),
    );
  }
}
