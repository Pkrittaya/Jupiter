import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';

class PageImageIndicator extends StatelessWidget {
  PageImageIndicator({
    super.key,
    required this.imageList,
    required this.pageController,
    required this.activePage,
    required this.isLoading,
  });

  final List<String> imageList;
  final PageController pageController;
  final int activePage;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isLoading,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(
            imageList.length > 1 ? imageList.length : 0,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: GestureDetector(
                onTap: () {
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: activePage == index
                        ? AppTheme.gray9CA3AF
                        : AppTheme.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
