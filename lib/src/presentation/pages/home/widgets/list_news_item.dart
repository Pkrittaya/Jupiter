// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jupiter_api/domain/entities/advertisement_entity.dart';
import 'package:jupiter/src/presentation/pages/home/widgets/news_item.dart';

class ListNewsItem extends StatelessWidget {
  ListNewsItem({
    super.key,
    required this.advertisementEntity,
    required this.onCheckClick,
  });

  AdvertisementEntity? advertisementEntity;
  bool Function({bool check, bool click}) onCheckClick;

  @override
  Widget build(BuildContext context) {
    int lengthItemNews = advertisementEntity?.news.length ?? 0;
    if (lengthItemNews > 0) {
      List<NewsItem> item = [];
      for (int i = 0; i < lengthItemNews; i++) {
        item.add(NewsItem(
          newsEntity: advertisementEntity?.news[i],
          isLastest: i == lengthItemNews - 1 ? true : false,
          onCheckClick: onCheckClick,
        ));
      }
      return Column(children: item);
    } else {
      return const SizedBox();
    }
  }
}
