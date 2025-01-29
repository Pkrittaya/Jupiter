import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';

class QrCodeAppBar extends StatefulWidget {
  const QrCodeAppBar({
    super.key,
    required this.onPressedBackButton,
    this.isDenied,
  });
  final Function() onPressedBackButton;
  final bool? isDenied;
  @override
  _QrCodeAppBarState createState() => _QrCodeAppBarState();
}

class _QrCodeAppBarState extends State<QrCodeAppBar> {
  double heightAppbar = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Positioned(
      top: height * 0.05,
      child: Container(
        width: width,
        height: heightAppbar,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: widget.onPressedBackButton,
              child: Container(
                width: 40,
                height: heightAppbar,
                decoration: BoxDecoration(
                    color: widget.isDenied == true
                        ? AppTheme.blueD
                        : AppTheme.white,
                    borderRadius: BorderRadius.circular(200)),
                child: Center(
                  child: Icon(Icons.arrow_back,
                      color: widget.isDenied == true
                          ? AppTheme.white
                          : AppTheme.blueD),
                ),
              ),
            ),
            const SizedBox(),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
