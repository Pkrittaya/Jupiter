import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/map/widgets/home_image_page_view_item.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class PageViewImage extends StatelessWidget {
  PageViewImage({
    super.key,
    required this.imageList,
    required this.pageController,
    required this.onPageChanged,
    required this.stationStatus,
  });

  final List<String> imageList;
  final PageController pageController;
  final Function(int) onPageChanged;
  final String stationStatus;

  @override
  Widget build(BuildContext context) {
    var sizeMedia = MediaQuery.of(context).size;
    return Container(
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 0,
        child: Stack(
          children: [
            Opacity(
              opacity: stationStatus == ConstValue.MAINTENANCE ? 0.5 : 1,
              child: SizedBox(
                height: sizeMedia.height * 0.17,
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
            ),
            Visibility(
              visible: stationStatus == ConstValue.MAINTENANCE,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppTheme.brown.withOpacity(0.65),
                ),
                width: double.infinity,
                height: sizeMedia.height * 0.17,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.build_circle,
                      size: 50,
                      color: AppTheme.white,
                    ),
                    const SizedBox(height: 4),
                    TextLabel(
                      text: translate(
                          'station_details_page.status_charger.maintenance'),
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.big),
                      fontWeight: FontWeight.bold,
                      color: AppTheme.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
