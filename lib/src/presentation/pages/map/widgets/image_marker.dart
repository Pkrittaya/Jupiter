import 'package:animated_styled_widget/animated_styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/station_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';

class ImageMarker extends StatefulWidget {
  ImageMarker({
    super.key,
    required this.stationData,
    required this.globalKeys,
    required this.loadMarkerStation,
  });
  final List<StationEntity> stationData;
  final List<GlobalKey> globalKeys;
  final bool loadMarkerStation;

  @override
  State<ImageMarker> createState() => _ImageMarkerState();
}

class _ImageMarkerState extends State<ImageMarker> {
  String statusRander = '';
  String imagePath = '';
  bool comment = false;
  Uint8List? bytes;
  List<Widget> widgetImage = [];
  var status = '';
  var connectorAvailable = '';

  checkStatusStation(statusMarker) {
    switch (statusMarker) {
      case ConstValue.OCCUPIED:
        imagePath = ImageAsset.pin_occu;
        break;
      case ConstValue.PREPARING:
        imagePath = ImageAsset.pin_occu;
        break;
      case ConstValue.AVAILABLE:
        imagePath = ImageAsset.pin_ava;
        break;
      case ConstValue.MAINTENANCE:
        imagePath = ImageAsset.pin_mainten;
        break;
      default:
        imagePath = ImageAsset.pin_outofservice;
        break;
    }
    return imagePath;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loadMarkerStation && widget.stationData.length > 0) {
      widgetImage.clear();
      for (int x = 0; x < widget.stationData.length; x++) {
        status = widget.stationData[x].statusMarker;
        connectorAvailable = '${widget.stationData[x].connectorAvailable}';
        widgetImage.add(Stack(children: [
          Container(
            height: 50,
            child: SvgPicture.asset(
              checkStatusStation(status),
              width: 50,
            ),
          ),
          (status != ConstValue.MAINTENANCE)
              ? Container(
                  padding: EdgeInsets.only(left: 5, top: 8),
                  height: 40,
                  child: SvgPicture.asset(
                    ImageAsset.logo_marker,
                    width: 40,
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(left: 1),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      height: 36,
                      width: 36,
                      child: Icon(
                        Icons.build_circle,
                        color: AppTheme.white,
                        size: 36,
                      ),
                    ),
                  ),
                ),
          (status == ConstValue.AVAILABLE)
              ? Container(
                  padding: EdgeInsets.only(left: 25),
                  height: 30,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        ImageAsset.circle_comment,
                        width: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7),
                        child: TextLabel(
                          text: connectorAvailable,
                          color: AppTheme.green,
                        ),
                      )
                    ],
                  ),
                )
              : SizedBox()
        ]));
      }
      return Transform.translate(
        offset: Offset(MediaQuery.of(context).size.width, 0),
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            children: widgetImage.mapIndexed((data, index) {
              return RepaintBoundary(
                key: widget.globalKeys[index],
                child: data,
              );
            }).toList(),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
