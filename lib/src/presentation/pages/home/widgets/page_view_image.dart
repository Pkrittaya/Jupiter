import 'package:flutter/material.dart';
import 'home_image_page_view_item.dart';

class PageViewImage extends StatelessWidget {
  PageViewImage({
    super.key,
    required this.imageList,
    required this.pageController,
    required this.onPageChanged,
    required this.activePage,
    // required this.onTapIndicator,
  });

  final List<String> imageList;
  final PageController pageController;
  final Function(int) onPageChanged;
  final int activePage;
  @override
  Widget build(BuildContext context) {
    var sizeMedia = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
      child: SizedBox(
        height: sizeMedia.height * 0.13,
        child: PageView.builder(
          controller: pageController,
          itemBuilder: (context, position) {
            String? imageUrl = imageList[position];
            return HomeImagePageViewItem(imageUrl: imageUrl);
          },
          itemCount: imageList.length,
          onPageChanged: onPageChanged, // Can be null
        ),
      ),
    );
  }
}
