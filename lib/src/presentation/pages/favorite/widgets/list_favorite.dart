import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/favorite_station_list_entily.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/favorite/widgets/favorite_search_item.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListFavorite extends StatefulWidget {
  const ListFavorite(
      {Key? key,
      required this.stationList,
      required this.currentLocation,
      required this.loading,
      required this.onSlide})
      : super(key: key);

  final List<FavoriteStationListEntity> stationList;
  final Position currentLocation;
  final bool loading;
  final Function(BuildContext, String, String) onSlide;

  @override
  _ListFavoriteState createState() => _ListFavoriteState();
}

class _ListFavoriteState extends State<ListFavorite> {
  @override
  Widget build(BuildContext context) {
    if (widget.stationList.length > 0 && !widget.loading) {
      return Container(
        color: AppTheme.white,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: ListView.separated(
              separatorBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 1,
                  color: AppTheme.borderGray,
                ),
              ),
              itemBuilder: (BuildContext context, int indexListView) {
                FavoriteStationListEntity? searchStationEntity =
                    widget.stationList[indexListView];
                return Slidable(
                  key: Key(searchStationEntity.stationId),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio:
                        80 * 100 / MediaQuery.of(context).size.width / 100,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          widget.onSlide(context, searchStationEntity.stationId,
                              searchStationEntity.stationName);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.all(10),
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  child: StationFavoriteItem(
                    StationEntity: searchStationEntity,
                    currentLocation: widget.currentLocation,
                  ),
                );
              },
              itemCount: widget.stationList.length,
            ),
          ),
        ),
      );
    } else if (widget.loading) {
      const int item = 3;
      return Container(
        color: AppTheme.white,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: ListView.separated(
              separatorBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 1,
                  color: AppTheme.borderGray,
                ),
              ),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int indexListView) {
                return Skeletonizer(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 16),
                        Container(
                          width: 110,
                          height: 113,
                          child: Bone.square(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          height: 113,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Bone.text(words: 1),
                              const SizedBox(height: 4),
                              Bone.text(words: 2),
                              const SizedBox(height: 12),
                              Bone.text(
                                words: 1,
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, 10),
                              ),
                              const SizedBox(height: 12),
                              Bone.circle(size: 30),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: item,
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAsset.img_default_empty,
              width: 150,
              height: 150,
            ),
            TextLabel(
              text: translate('empty.favorite'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.superlarge),
              color: AppTheme.black40,
            )
          ],
        ),
      );
    }
  }
}
