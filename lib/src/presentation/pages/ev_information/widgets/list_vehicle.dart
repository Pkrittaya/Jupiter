import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter_api/domain/entities/car_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/ev_information_add/ev_information_add_page.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListVehicle extends StatefulWidget {
  const ListVehicle({
    Key? key,
    required this.carList,
    required this.onSlide,
    required this.loading,
    required this.fromFleet,
  }) : super(key: key);

  final List<CarEntity> carList;
  final Function(BuildContext, {required CarEntity carEntity}) onSlide;
  final bool loading;
  final bool? fromFleet;

  @override
  _ListVehicleState createState() => _ListVehicleState();
}

class _ListVehicleState extends State<ListVehicle> {
  @override
  Widget build(BuildContext context) {
    if (widget.carList.length > 0 && !widget.loading) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.white,
        ),
        child: Column(
          children: [
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox();
                  },
                  shrinkWrap: true,
                  itemCount: widget.carList.length,
                  itemBuilder: (context, index) {
                    CarEntity carEntity = widget.carList[index];
                    return Column(
                      children: [
                        widget.fromFleet == true
                            ? renderRowListCar(carEntity)
                            : Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 70 *
                                      100 /
                                      MediaQuery.of(context).size.width /
                                      100,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        widget.onSlide(context,
                                            carEntity: carEntity);
                                        debugPrint(
                                            'ID : ${carEntity.vehicleNo}');
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
                                child: renderRowListCar(carEntity),
                              ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          height: 1,
                          color: AppTheme.borderGray,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: widget.fromFleet == true ? 0 : 80)
          ],
        ),
      );
    } else if (widget.loading) {
      const int item = 3;
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.white,
        ),
        child: Column(
          children: [
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox();
                  },
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: item,
                  itemBuilder: (context, index) {
                    return Skeletonizer(
                      enabled: true,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.19,
                                  height:
                                      MediaQuery.of(context).size.width * 0.19,
                                  child: Bone.square(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const SizedBox(width: 18),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Bone.text(words: 2),
                                    const SizedBox(height: 8),
                                    Bone.text(
                                      words: 1,
                                      fontSize: Utilities
                                          .sizeFontWithDesityForDisplay(
                                        context,
                                        AppFontSize.supermini,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                              height: 1,
                              color: AppTheme.borderGray,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
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
              text: translate('empty.vehicle'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.superlarge),
              color: AppTheme.black40,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      );
    }
  }

  Widget renderRowListCar(CarEntity carEntity) {
    return Material(
      color: AppTheme.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return EvInformationAddPage(
              carEntity: carEntity,
              fromFleet: widget.fromFleet,
            );
          }));
        },
        child: Container(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Container(
                width: 70,
                height: 70,
                child: carEntity.image != null && carEntity.image!.isNotEmpty
                    ? ImageNetworkJupiter(url: carEntity.image ?? '')
                    // Image.network(
                    //     carEntity.image!,
                    //   )
                    : SvgPicture.asset(
                        ImageAsset.vehicle_non_img,
                      ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextLabel(
                      text: '${carEntity.brand} ${carEntity.model}',
                      color: AppTheme.blueDark,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.big),
                      fontWeight: FontWeight.bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    TextLabel(
                      text: '${carEntity.licensePlate} ${carEntity.province}',
                      color: AppTheme.gray9CA3AF,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.little),
                    ),
                  ],
                ),
              ),
              carEntity.defalut
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: AppTheme.lightBlue10),
                      child: TextLabel(
                        text: carEntity.defalut
                            ? translate(
                                'ev_information_add_page.default_vehicle.default')
                            : '',
                        color: AppTheme.blueDark,
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.little),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
