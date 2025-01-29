import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/station_details/cubit/station_details_cubit.dart';
import '../../../../apptheme.dart';

class ArrowBackAtAppBar extends StatefulWidget {
  ArrowBackAtAppBar(
      {super.key,
      required StationDetailEntity? stationDetailEntity,
      required this.favoriteStation,
      required this.onPressedBack,
      required this.isLoading,
      required this.loadingFavorite})
      : _stationDetailEntity = stationDetailEntity;

  final StationDetailEntity? _stationDetailEntity;
  final Function() onPressedBack;
  final bool favoriteStation;
  final bool isLoading;
  final bool loadingFavorite;

  @override
  State<ArrowBackAtAppBar> createState() => _ArrowBackAtAppBarState();
}

class _ArrowBackAtAppBarState extends State<ArrowBackAtAppBar> {
  void onPressdSaveUpdateFavoriteStation(
      BuildContext widgetContext, String stationId, String stationName) {
    if (!widget.loadingFavorite) {
      BlocProvider.of<StationDetailsCubit>(widgetContext)
          .updateFavorite(stationId: stationId, stationName: stationName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16),
      margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: const EdgeInsets.only(left: 16),
                width: 36,
                height: 36,
                child: RawMaterialButton(
                  onPressed: widget.onPressedBack,
                  elevation: 2.0,
                  fillColor: Colors.white,
                  shape: const CircleBorder(),
                  child: SvgPicture.asset(
                    ImageAsset.ic_arrow_left,
                    width: 24,
                    height: 24,
                  ),
                )),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: !widget.isLoading,
                  child: Container(
                    width: 36,
                    height: 36,
                    child: RawMaterialButton(
                      onPressed: () {
                        onPressdSaveUpdateFavoriteStation(
                            context,
                            widget._stationDetailEntity!.stationId,
                            widget._stationDetailEntity!.stationName);
                      },
                      elevation: 2.0,
                      fillColor: widget.loadingFavorite
                          ? AppTheme.borderGray
                          : AppTheme.white,
                      shape: const CircleBorder(),
                      child: SvgPicture.asset(
                        widget.favoriteStation
                            ? ImageAsset.ic_heart_select
                            : ImageAsset.ic_heart,
                        width: 20,
                        height: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
