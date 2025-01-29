import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/connector_type_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

// ignore: must_be_immutable
class ModalFilter extends StatefulWidget {
  ModalFilter({
    Key? key,
    this.onChangedApply,
    this.onchangeReset,
    this.isCheckedDistance,
    this.isCheckedOpenService,
    this.isCheckedChargerAvailable,
    this.isCheckedACCS1,
    this.isCheckedACCS2,
    this.isCheckedACCHAdeMO,
    this.isCheckedDCCS1,
    this.isCheckedDCCS2,
    this.isCheckedDCCHAdeMO,
    required this.isPermissionLocation,
  }) : super(key: key);
  final Function(
    bool? openService,
    bool? chargerAvailble,
    bool? distance,
    bool? accs1,
    bool? accs2,
    bool? ACCHAdeMO,
    bool? dccs1,
    bool? dccs2,
    bool? dcCHAdeMO,
  )? onChangedApply;
  final Function()? onchangeReset;
  bool? isCheckedDistance;
  bool? isCheckedOpenService;
  bool? isCheckedChargerAvailable;
  bool? isCheckedACCS1;
  bool? isCheckedACCS2;
  bool? isCheckedACCHAdeMO;
  bool? isCheckedDCCS1;
  bool? isCheckedDCCS2;
  bool? isCheckedDCCHAdeMO;
  final bool isPermissionLocation;

  @override
  _ModalFilterState createState() => _ModalFilterState();
}

class _ModalFilterState extends State<ModalFilter> {
  List<ConnectorTypeEntity>? filterMapType = List.empty(growable: true);
  List<String>? selectedFilter = List.empty(growable: true);

  final formKey = GlobalKey<FormState>();
  double buttonChargingEnergyHeight = 45;
  double spaceLineHeight = 16;
  double widthSelector = 0.25;
  double widthSizedbox = 0.15;
  double heightItem = 35;

  bool isCheckedDistance = false;
  bool isCheckedOpenService = false;
  bool isCheckedChargerAvailable = false;

  bool isCheckedACCS1 = false;
  bool isCheckedACCS2 = false;
  bool isCheckedACCHAdeMO = false;
  bool isCheckedDCCS1 = false;
  bool isCheckedDCCS2 = false;
  bool isCheckedDCCHAdeMO = false;

  bool applyFilter = false;

  @override
  void initState() {
    super.initState();
    isCheckedDistance = widget.isCheckedDistance!;
    isCheckedOpenService = widget.isCheckedOpenService!;
    isCheckedChargerAvailable = widget.isCheckedChargerAvailable!;
    isCheckedACCS1 = widget.isCheckedACCS1!;
    isCheckedACCS2 = widget.isCheckedACCS2!;
    isCheckedACCHAdeMO = widget.isCheckedACCHAdeMO!;
    isCheckedDCCS1 = widget.isCheckedDCCS1!;
    isCheckedDCCS2 = widget.isCheckedDCCS2!;
    isCheckedDCCHAdeMO = widget.isCheckedDCCHAdeMO!;
  }

  @override
  void dispose() {
    super.dispose();
    if (!applyFilter) {
      widget.isCheckedDistance = isCheckedDistance;
      widget.isCheckedDistance = isCheckedDistance;
      widget.isCheckedOpenService = isCheckedOpenService;
      widget.isCheckedChargerAvailable = isCheckedChargerAvailable;
      widget.isCheckedACCS1 = isCheckedACCS1;
      widget.isCheckedACCS2 = isCheckedACCS2;
      widget.isCheckedACCHAdeMO = isCheckedACCHAdeMO;
      widget.isCheckedDCCS1 = isCheckedDCCS1;
      widget.isCheckedDCCS2 = isCheckedDCCS2;
      widget.isCheckedDCCHAdeMO = isCheckedDCCHAdeMO;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          height: MediaQuery.of(context).size.height - 50,
          child: Stack(
            children: [
              Column(
                children: [
                  _headerAndIconClose(),
                  SizedBox(height: 8),
                  Container(
                    // color: AppTheme.white,
                    height: MediaQuery.of(context).size.height * 0.675,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _otherCheckBox(),
                          renderDivider(),
                          _chargerACFilter(),
                          renderDivider(),
                          _chargerDCFilter(),
                          // _otherOperators()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _bottomFilter(),
            ],
          ),
        ));
  }

  Widget _headerAndIconClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextLabel(
          text: translate("map_page.map_filter.filter"),
          fontWeight: FontWeight.bold,
          color: AppTheme.black,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.title),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: AppTheme.black),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _otherCheckBox() {
    return Column(
      children: [
        widget.isPermissionLocation
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextLabel(
                    text: translate("map_page.map_filter.distance"),
                    fontSize: Utilities.sizeFontWithDesityForDisplay(
                        context, AppFontSize.normal),
                  ),
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    checkColor: AppTheme.white,
                    activeColor: AppTheme.blueD,
                    value: widget.isCheckedDistance ?? false,
                    onChanged: (value) {
                      widget.isCheckedDistance = value;
                      setState(() {});
                    },
                  ),
                ],
              )
            : SizedBox.shrink(),
        widget.isPermissionLocation ? SizedBox(height: 4) : SizedBox.shrink(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextLabel(
              text: translate("map_page.map_filter.openForService"),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.normal),
            ),
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              checkColor: AppTheme.white,
              activeColor: AppTheme.blueD,
              value: widget.isCheckedOpenService ?? false,
              onChanged: (value) {
                widget.isCheckedOpenService = value!;

                setState(() {});
              },
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextLabel(
              text: translate("map_page.map_filter.chargerAvailable"),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.normal),
            ),
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              checkColor: AppTheme.white,
              activeColor: AppTheme.blueD,
              value: widget.isCheckedChargerAvailable ?? false,
              onChanged: (value) {
                widget.isCheckedChargerAvailable = value!;

                setState(() {});
              },
            ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     TextLabel(
        //       text: translate("map_page.map_filter.onlyMatchesCar"),
        //       fontSize: Utilities.sizeFontWithDesityForDisplay(
        //           context, AppFontSize.normal),
        //     ),
        //     Checkbox(
        //       checkColor: AppTheme.white,
        //       activeColor: AppTheme.blueD,
        //       value: isCheckedOnlyMatchCar,
        //       onChanged: (bool? value) {
        //         isCheckedOnlyMatchCar = value!;
        //         setState(() {});
        //       },
        //     ),
        //   ],
        // )
      ],
    );
  }

  Widget _chargerACFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextLabel(
            text: translate("map_page.map_filter.ac"),
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.large),
            fontWeight: FontWeight.w700,
            color: AppTheme.blueDark,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ImageAsset.ic_ac_cs1,
                  width: 32,
                  height: 32,
                ),
                SizedBox(
                  width: 14,
                ),
                TextLabel(
                  text: translate("connecterInCharger.actype.CS1"),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.w700,
                  color: AppTheme.blueDark,
                ),
              ],
            ),
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              checkColor: AppTheme.white,
              activeColor: AppTheme.blueD,
              value: widget.isCheckedACCS1 ?? false,
              onChanged: (value) {
                widget.isCheckedACCS1 = value!;

                setState(() {});
              },
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ImageAsset.ic_ac_cs2,
                  width: 32,
                  height: 32,
                ),
                SizedBox(
                  width: 14,
                ),
                TextLabel(
                  text: translate("connecterInCharger.actype.CS2"),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.w700,
                  color: AppTheme.blueDark,
                ),
              ],
            ),
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              checkColor: AppTheme.white,
              activeColor: AppTheme.blueD,
              value: widget.isCheckedACCS2 ?? false,
              onChanged: (value) {
                widget.isCheckedACCS2 = value!;

                setState(() {});
              },
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ImageAsset.ic_ac_chadeMO,
                  width: 32,
                  height: 32,
                ),
                SizedBox(
                  width: 14,
                ),
                TextLabel(
                  text: translate("connecterInCharger.actype.CHaDEMO"),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.w700,
                  color: AppTheme.blueDark,
                ),
              ],
            ),
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              checkColor: AppTheme.white,
              activeColor: AppTheme.blueD,
              value: widget.isCheckedACCHAdeMO ?? false,
              onChanged: (value) {
                widget.isCheckedACCHAdeMO = value!;

                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _chargerDCFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextLabel(
            text: translate("map_page.map_filter.dc"),
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.large),
            fontWeight: FontWeight.w700,
            color: AppTheme.blueDark,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ImageAsset.ic_dc_cs1,
                  width: 32,
                  height: 32,
                ),
                SizedBox(
                  width: 14,
                ),
                TextLabel(
                  text: translate("connecterInCharger.dctype.CS1"),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.w700,
                  color: AppTheme.blueDark,
                ),
              ],
            ),
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              checkColor: AppTheme.white,
              activeColor: AppTheme.blueD,
              value: widget.isCheckedDCCS1 ?? false,
              onChanged: (value) {
                widget.isCheckedDCCS1 = value!;

                setState(() {});
              },
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ImageAsset.ic_dc_cs2,
                  width: 32,
                  height: 32,
                ),
                SizedBox(
                  width: 14,
                ),
                TextLabel(
                  text: translate("connecterInCharger.dctype.CS2"),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.w700,
                  color: AppTheme.blueDark,
                ),
              ],
            ),
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              checkColor: AppTheme.white,
              activeColor: AppTheme.blueD,
              value: widget.isCheckedDCCS2 ?? false,
              onChanged: (value) {
                widget.isCheckedDCCS2 = value!;

                setState(() {});
              },
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ImageAsset.ic_dc_chadeMO,
                  width: 32,
                  height: 32,
                ),
                SizedBox(
                  width: 14,
                ),
                TextLabel(
                  text: translate("connecterInCharger.dctype.CHaDEMO"),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.w700,
                  color: AppTheme.blueDark,
                ),
              ],
            ),
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              checkColor: AppTheme.white,
              activeColor: AppTheme.blueD,
              value: widget.isCheckedDCCHAdeMO ?? false,
              onChanged: (value) {
                widget.isCheckedDCCHAdeMO = value!;

                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _bottomFilter() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(16),
        // color: AppTheme.gray9CA3AF,
        height: MediaQuery.of(context).size.height * 0.175,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.blueD,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
                onPressed: () {
                  applyFilter = true;
                  widget.onChangedApply!(
                      widget.isCheckedOpenService,
                      widget.isCheckedChargerAvailable,
                      widget.isCheckedDistance,
                      widget.isCheckedACCS1,
                      widget.isCheckedACCS2,
                      widget.isCheckedACCHAdeMO,
                      widget.isCheckedDCCS1,
                      widget.isCheckedDCCS2,
                      widget.isCheckedDCCHAdeMO);
                },
                child: TextLabel(
                  text: translate("map_page.map_filter.apply"),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(context, 20),
                  color: AppTheme.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 46,
                child: TextButton(
                  onPressed: widget.onchangeReset,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                        // side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  child: TextLabel(
                    text: translate("map_page.map_filter.reset"),
                    fontSize:
                        Utilities.sizeFontWithDesityForDisplay(context, 20),
                  ),
                )),
            const SizedBox(
              width: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget renderDivider() {
    return Container(
        height: 1,
        margin: const EdgeInsets.only(top: 12, bottom: 12),
        color: AppTheme.borderGray);
  }

  // Widget _otherOperators() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       TextLabel(
  //         text: 'Other Operators',
  //         fontSize: Utilities.sizeFontWithDesityForDisplay(
  //             context, AppFontSize.large),
  //         fontWeight: FontWeight.w700,
  //         color: AppTheme.blueDark,
  //       ),
  //       Switch(
  //         value: defaultOperators,
  //         activeColor: AppTheme.blueD,
  //         onChanged: (value) {
  //           defaultOperators = value;
  //           setState(() {});
  //         },
  //       ),
  //     ],
  //   );
  // }
}
