import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StationName extends StatefulWidget {
  StationName({
    super.key,
    required this.stationDetailEntity,
    required this.isLoading,
  });

  final StationDetailEntity? stationDetailEntity;
  final bool isLoading;
  @override
  State<StationName> createState() => _StationNameState();
}

class _StationNameState extends State<StationName> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppTheme.green,
      padding: EdgeInsets.fromLTRB(32, 150, 32, 0),
      child: Material(
        shadowColor: AppTheme.gray9CA3AF,
        elevation: 1,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            children: [
              SvgPicture.asset(
                ImageAsset.logo_station,
                width: 76,
                height: 76,
              ),
              const SizedBox(width: 8),
              !widget.isLoading
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: TextLabel(
                        text:
                            '${widget.stationDetailEntity?.stationName != null ? widget.stationDetailEntity?.stationName : '. . .'}',
                        color: AppTheme.blueDark,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context,
                          AppFontSize.superlarge,
                        ),
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )
                  : Skeletonizer(
                      enabled: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Bone.text(words: 2),
                          Bone.text(words: 1),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
