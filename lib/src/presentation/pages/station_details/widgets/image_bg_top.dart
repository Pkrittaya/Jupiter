// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:jupiter/src/images_asset.dart';

class ImageBGTop extends StatefulWidget {
  const ImageBGTop({
    super.key,
    required StationDetailEntity? stationDetailEntity,
  }) : _stationDetailEntity = stationDetailEntity;

  final StationDetailEntity? _stationDetailEntity;
  @override
  State<ImageBGTop> createState() => _ImageBGTopState();
}

class _ImageBGTopState extends State<ImageBGTop> {
  // List<String> imageList = List.empty(growable: true);

  // @override
  // void initState() {
  //   imageList = widget._stationDetailEntity?.images ?? [];
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // if (widget._stationDetailEntity?.images != null) {
    //   debugPrint(
    //       '_stationDetailEntity ${widget._stationDetailEntity?.images![0]}');
    // }
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 5.0,
        minWidth: 5.0,
        maxHeight: 240,
      ),
      child:
          // widget._stationDetailEntity?.images != null
          //     ? Container(
          //         decoration: BoxDecoration(
          //           color: AppTheme.black5,
          //         ),
          //         child: Image.network(
          //           widget._stationDetailEntity?.images![0] ?? '',
          //           width: double.infinity,
          //           fit: BoxFit.cover,
          //         ),
          //       )
          //     :
          Container(
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
    );
  }
}
