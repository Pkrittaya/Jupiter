import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../apptheme.dart';

class HomeImagePageViewItem extends StatelessWidget {
  const HomeImagePageViewItem({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Shimmer.fromColors(
              baseColor: AppTheme.grayF1F5F9,
              highlightColor: AppTheme.borderGray,
              child: Container(
                height: 20,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
          imageUrl ?? '',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
