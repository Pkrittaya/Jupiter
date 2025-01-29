import 'package:flutter/material.dart';

class ChargingPageLoading extends StatelessWidget {
  const ChargingPageLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: const Center(
        child: CircularProgressIndicator(
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}
