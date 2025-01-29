import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/fleet_card_item_entity.dart';

class FilterListFleet extends StatefulWidget {
  const FilterListFleet(
      {Key? key, required this.onTapFilter, required this.selectFilter})
      : super(key: key);

  final Function(String) onTapFilter;
  final String selectFilter;

  @override
  State<FilterListFleet> createState() => _FilterListFleetState();
}

class _FilterListFleetState extends State<FilterListFleet> {
  // filter & search station
  FocusNode focusSearchStation = FocusNode();
  TextEditingController searchControl = TextEditingController();
  List<FleetCardItemEntity>? fleetCardList = List.empty(growable: true);
  GlobalKey<State<StatefulWidget>> keySearchStation =
      GlobalKey<State<StatefulWidget>>();
  String isExpandedStation = '';

  List<FilterButton> listFilterButton = [
    FilterButton(
        key: 'all',
        text: '  ${translate('fleet_page.card.filter.all')}  ',
        icon: '',
        colorBorder: AppTheme.blueDark,
        colorBackground: AppTheme.blueLight,
        colorFont: AppTheme.blueDark),
    FilterButton(
        key: FleetCardType.FLEET,
        text: translate('fleet_page.card.filter.fleet_card'),
        icon: ImageAsset.ic_card,
        colorBorder: AppTheme.blueDark,
        colorBackground: AppTheme.blueLight,
        colorFont: AppTheme.blueDark),
    FilterButton(
        key: FleetCardType.RFID,
        text: translate('fleet_page.card.filter.rfid'),
        icon: ImageAsset.ic_rfid,
        colorBorder: AppTheme.orange,
        colorBackground: AppTheme.orange20,
        colorFont: AppTheme.orange),
    FilterButton(
        key: FleetCardType.AUTOCHARGE,
        text: translate('fleet_page.card.filter.auto_charge'),
        icon: ImageAsset.ic_car_charging,
        colorBorder: AppTheme.green,
        colorBackground: AppTheme.green20,
        colorFont: AppTheme.green),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.centerLeft,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: listFilterButton.length,
        separatorBuilder: (context, index) => const SizedBox(width: 7),
        itemBuilder: (BuildContext context, int index) {
          // String text = getTextButtonForFiltter(index);
          String key = listFilterButton[index].key;
          String text = listFilterButton[index].text;
          String icon = listFilterButton[index].icon;
          Color colorBorder = listFilterButton[index].colorBorder;
          Color colorBackground = listFilterButton[index].colorBackground;
          Color colorFont = listFilterButton[index].colorFont;
          return InkWell(
            focusColor: AppTheme.transparent,
            highlightColor: AppTheme.transparent,
            hoverColor: AppTheme.transparent,
            splashColor: AppTheme.transparent,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                margin: EdgeInsets.only(
                    left: index == 0 ? 16 : 0,
                    right: index == listFilterButton.length - 1 ? 16 : 0),
                decoration: BoxDecoration(
                  color: (widget.selectFilter == key)
                      ? colorBackground
                      : AppTheme.white,
                  border: Border.all(
                      color: (widget.selectFilter == key)
                          ? colorBorder
                          : AppTheme.borderGray,
                      width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.gray9CA3AF,
                      blurRadius: 0,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    (icon == '')
                        ? SizedBox.shrink()
                        : SvgPicture.asset(
                            icon,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                                (widget.selectFilter == key)
                                    ? colorFont
                                    : AppTheme.gray9CA3AF,
                                BlendMode.srcIn),
                          ),
                    SizedBox(width: icon != '' ? 5 : 0),
                    TextLabel(
                      text: text,
                      color: (widget.selectFilter == key)
                          ? colorFont
                          : AppTheme.gray9CA3AF,
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context,
                        AppFontSize.normal,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              widget.onTapFilter(key);
            },
          );
        },
      ),
    );
  }
}

class FilterButton {
  FilterButton(
      {required this.key,
      required this.text,
      required this.icon,
      required this.colorBorder,
      required this.colorBackground,
      required this.colorFont});
  final String key;
  final String text;
  final String icon;
  final Color colorBorder;
  final Color colorBackground;
  final Color colorFont;
}
