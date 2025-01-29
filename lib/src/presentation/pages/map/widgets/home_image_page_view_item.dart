import 'package:flutter/material.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import '../../../../apptheme.dart';

class HomeImagePageViewItem extends StatelessWidget {
  const HomeImagePageViewItem({
    super.key,
    required this.imageUrl,
    this.isDetail,
  });

  final String? imageUrl;
  final bool? isDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isDetail == true ? 0 : 10),
        color: AppTheme.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isDetail == true ? 0 : 10),
        child: imageUrl == ''
            ? Image.asset(
                ImageAsset.img_station_search_png,
                width: 110,
                fit: BoxFit.cover,
              )
            : ImageNetworkJupiter(
                url: imageUrl ?? '',
                fit: BoxFit.cover,
              ),
        // Image.network(
        //   imageUrl ?? '',
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
