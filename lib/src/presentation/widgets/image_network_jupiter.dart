import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:shimmer/shimmer.dart';

class ImageNetworkJupiter extends StatelessWidget {
  const ImageNetworkJupiter({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.widthLoading,
    this.heightLoading,
    this.fit,
  });
  final String url;
  final double? width;
  final double? height;
  final double? widthLoading;
  final double? heightLoading;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    // return url.isNotEmpty
    //     ? Image.network(
    //         url,
    //         width: width,
    //         height: height,
    //         fit: fit,
    //         loadingBuilder: (context, child, loadingProgress) {
    //           // debugPrint(
    //           // "LoadingImageNetworkProgress cumulativeBytesLoaded url $url ${loadingProgress?.cumulativeBytesLoaded}");
    //           // debugPrint(
    //           //     "LoadingImageNetworkProgress expectedTotalBytes ${loadingProgress?.expectedTotalBytes}");
    //           if (loadingProgress?.cumulativeBytesLoaded != null) {
    //             return CircularProgressIndicator(
    //               color: AppTheme.blueD,
    //             );
    //           } else {
    //             return child;
    //           }
    //         },
    //         errorBuilder: (context, error, stackTrace) {
    //           return Icon(Icons.no_photography);
    //         },
    //       )
    //     : Container();
    return url.isNotEmpty
        ? CachedNetworkImage(
            imageUrl: url,
            width: width,
            height: height,
            fit: fit,
            fadeInDuration: Duration(milliseconds: 100),
            fadeOutDuration: Duration(milliseconds: 100),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Shimmer.fromColors(
              baseColor: AppTheme.grayF1F5F9,
              highlightColor: AppTheme.borderGray,
              child: Container(
                height: heightLoading ?? double.infinity,
                width: widthLoading ?? double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.no_photography),
          )
        : SizedBox();
  }
}
