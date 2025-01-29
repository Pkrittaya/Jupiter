import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/map/widgets/home_image_page_view_item.dart';
import 'package:shimmer/shimmer.dart';

class PageViewImage extends StatelessWidget {
  PageViewImage({
    super.key,
    required this.imageList,
    required this.pageController,
    required this.onPageChanged,
    required this.isLoading,
  });

  final List<String> imageList;
  final PageController pageController;
  final Function(int) onPageChanged;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    // var sizeMedia = MediaQuery.of(context).size;
    return Container(
      constraints: const BoxConstraints(
        minHeight: 5.0,
        minWidth: 5.0,
        maxHeight: 240,
      ),
      child: Container(
        child: !isLoading
            ? imageList.length > 0
                ? PageView.builder(
                    controller: pageController,
                    itemBuilder: (context, position) {
                      String? imageUrl = imageList[position];
                      return HomeImagePageViewItem(
                        imageUrl: imageUrl,
                        isDetail: true,
                      );
                    },
                    itemCount: imageList.length,
                    onPageChanged: onPageChanged, // Can be null
                  )
                : Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.black5,
                      image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage(ImageAsset.img_station_search_png),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
            : Shimmer.fromColors(
                baseColor: AppTheme.blueD,
                highlightColor: AppTheme.lightBlue60,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.black5,
                    image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage(ImageAsset.img_station_search_png),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
