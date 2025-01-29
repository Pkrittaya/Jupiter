import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/select_vehicle/select_vehicle_page.dart';
import 'package:jupiter_api/domain/entities/car_select_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/presentation/widgets/tootip_information.dart';
import 'package:jupiter/src/utilities.dart';

class SelectVehicle extends StatefulWidget {
  const SelectVehicle(
      {Key? key,
      required this.indexSelected,
      required this.listItemVehicle,
      required this.onSelectVehicle,
      required this.onClickAddVehicle,
      required this.fromFleet,
      required this.limitShowListVenhicle})
      : super(key: key);

  final int indexSelected;
  final List<CarSelectEntity> listItemVehicle;
  final Function(int) onSelectVehicle;
  final Function() onClickAddVehicle;
  final bool fromFleet;
  final int limitShowListVenhicle;

  @override
  _SelectVehicleState createState() => _SelectVehicleState();
}

class _SelectVehicleState extends State<SelectVehicle> {
  @override
  void initState() {
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  double buttonChargingEnergyHeight = 45;
  double spaceLineHeight = 16;
  double widthSelector = 0.25;
  double widthSizedbox = 0.15;
  double heightItem = 35;

  bool isSelected(int index) {
    return widget.indexSelected == index;
  }

  String getTextDisplayVehicle(CarSelectEntity item) {
    if (widget.fromFleet == true)
      return '${item.licensePlate} ${item.province}';
    else
      return '${item.brand} ${item.model}';
  }

  int getListVehicleMore() {
    if (widget.fromFleet == true) {
      return (widget.listItemVehicle.length >= widget.limitShowListVenhicle
          ? widget.limitShowListVenhicle
          : widget.listItemVehicle.length);
    } else {
      debugPrint(
          'listItemVehicle ${(widget.listItemVehicle.length >= widget.limitShowListVenhicle ? widget.limitShowListVenhicle + 1 : widget.listItemVehicle.length + 1)}');
      return (widget.listItemVehicle.length >= widget.limitShowListVenhicle
          ? widget.limitShowListVenhicle + 1
          : widget.listItemVehicle.length + 1);
    }
  }

  void onSaveVehicle(int index) {
    isSelected(index);
    widget.onSelectVehicle(index);
  }

  void onNavigateSelectVehicle() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SelectVehiclePage(
        typePage: 'CHECKIN',
        listCarEntity: widget.listItemVehicle,
        onSaveVehicle: onSaveVehicle,
        indexSelected: widget.indexSelected,
        qrCodeData: '',
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextLabel(
                              text: translate(
                                  'check_in_page.select_vehicle.select_vehicle'),
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.big),
                              fontWeight: FontWeight.bold,
                              color: AppTheme.blueDark),
                          const SizedBox(width: 10),
                          TooltipInformation(
                            message: translate('check_in_page.information'),
                          ),
                        ],
                      ),
                      (widget.listItemVehicle.length >=
                              widget.limitShowListVenhicle)
                          ? InkWell(
                              onTap: () {
                                onNavigateSelectVehicle();
                              },
                              child: TextLabel(
                                  text: translate(
                                      'check_in_page.select_vehicle.view_more'),
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.small),
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.blueDark),
                            )
                          : SizedBox()
                    ],
                  ),
                  Container(
                    child: SizedBox(
                      height: 110,
                      width: double.infinity,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: getListVehicleMore(),
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            return _renderItemVehicle(index);
                          }),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget _imageUrlItem(String url, int index) {
    if (url == '') {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppTheme.white,
          border: Border.all(
            color: isSelected(index) ? AppTheme.lightBlue : AppTheme.white,
            width: isSelected(index) ? 1 : 0,
          ),
        ),
        child: SvgPicture.asset(
          ImageAsset.vehicle_non_img,
        ),
      );
    } else {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppTheme.white,
          border: Border.all(
            color: isSelected(index) ? AppTheme.lightBlue : AppTheme.white,
            width: isSelected(index) ? 1 : 0,
          ),
          image: DecorationImage(
            image: NetworkImage(url),
            // fit: BoxFit.cover,
          ),
        ),
      );
    }
  }

  Widget _renderItemVehicle(int index) {
    if (widget.fromFleet == true) {
      if (widget.listItemVehicle.length >= widget.limitShowListVenhicle) {
        if (index < widget.limitShowListVenhicle - 1) {
          return _itemVehicle(index);
        } else {
          return _viewMore();
        }
      } else {
        return _itemVehicle(index);
      }
    } else {
      if (widget.listItemVehicle.length >= widget.limitShowListVenhicle) {
        if (index < widget.limitShowListVenhicle - 1) {
          return _itemVehicle(index);
        } else if (index == widget.limitShowListVenhicle - 1) {
          return _addVehicle();
        } else {
          return _viewMore();
        }
      } else {
        if (index < widget.listItemVehicle.length) {
          return _itemVehicle(index);
        } else {
          return _addVehicle();
        }
      }
    }
  }

  Widget _itemVehicle(int value) {
    return Container(
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: GestureDetector(
            onTap: () {
              widget.onSelectVehicle(value);
            },
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _imageUrlItem(
                      widget.listItemVehicle[value].image ?? '', value),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 16,
                    child: Center(
                      child: TextLabel(
                          text: getTextDisplayVehicle(
                              widget.listItemVehicle[value]),
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.small),
                          fontWeight: FontWeight.bold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: isSelected(value)
                              ? AppTheme.lightBlue
                              : AppTheme.gray9CA3AF),
                    ),
                  )
                ],
              ),
            )));
  }

  Widget _addVehicle() {
    return Container(
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: GestureDetector(
            onTap: widget.onClickAddVehicle,
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DottedBorder(
                    color: AppTheme.gray9CA3AF,
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    dashPattern: const [6, 6],
                    child: Container(
                        width: 78,
                        height: 76,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: TextLabel(
                              text: translate(
                                  'check_in_page.select_vehicle.add_vehicle'),
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.small),
                              fontWeight: FontWeight.bold,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              color: AppTheme.gray9CA3AF),
                        )),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )));
  }

  Widget _viewMore() {
    return Container(
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: GestureDetector(
            onTap: () {
              onNavigateSelectVehicle();
            },
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.3,
                          blurRadius: 5,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(200),
                      color: AppTheme.white,
                      child: Icon(
                        Icons.arrow_forward,
                        size: 25,
                        color: AppTheme.pttBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 16,
                    child: Center(
                      child: TextLabel(
                          text: 'ดูเพิ่มเติม',
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.small),
                          fontWeight: FontWeight.bold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: AppTheme.blueDark),
                    ),
                  )
                ],
              ),
            )));
  }
}
