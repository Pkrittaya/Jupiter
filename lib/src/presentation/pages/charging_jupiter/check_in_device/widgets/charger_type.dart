import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/icon_with_text.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class ChargerType extends StatefulWidget {
  ChargerType({Key? key, required this.onChanged}) : super(key: key);
  final void Function(bool) onChanged;

  @override
  _ChargerTypeState createState() => _ChargerTypeState();
}

class _ChargerTypeState extends State<ChargerType> {
  String selectType = '';
  List<String> valSelect = ['A', 'B', 'C'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: valSelect.length,
      separatorBuilder: (context, index) => const SizedBox(width: 16),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Container(
            width: 250,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: (selectType == valSelect[index])
                    ? AppTheme.blueD
                    : AppTheme.white,
              ),
              borderRadius: BorderRadius.circular(10),
              color: (selectType == valSelect[index])
                  ? AppTheme.lightBlue20
                  : AppTheme.white,
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  ImageAsset.ic_ev_type,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(height: 5),
                _positionconnecter(context),
                const SizedBox(height: 5),
                _deviceType(context, 'AC Type 2', 'AC 7kW ๐ 4.50 THB/kWh'),
              ],
            ),
          ),
          onTap: () {
            widget.onChanged(true);
            selectType = valSelect[index];
          },
        );
      },
    ));
  }
}

Widget _positionconnecter(context) {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.white,
            backgroundColor: AppTheme.blueDark,
          ),
          onPressed: () {},
          child: TextLabel(
            text: translate("check_in_page.charger_data.left"),
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.normal),
            color: AppTheme.white,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(foregroundColor: AppTheme.darkBlue20),
          onPressed: () {},
          child: TextLabel(
            text: translate("check_in_page.charger_data.middle"),
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.normal),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(foregroundColor: AppTheme.darkBlue20),
          onPressed: () {},
          child: TextLabel(
            text: translate("check_in_page.charger_data.right"),
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.normal),
          ),
        ),
      ],
    ),
  );
}

Widget _deviceType(
    BuildContext context, String chargerType, String totalConnector) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextLabel(
              text: chargerType,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.normal),
              fontWeight: FontWeight.w700,
              color: AppTheme.blueDark,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextLabel(
                  text: totalConnector,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.small),
                  fontWeight: FontWeight.w400,
                  color: AppTheme.black40,
                ),
                const SizedBox(
                  width: 4,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: AppTheme.green80,
          ),
          child: IconWithText(
            icon: Icons.bolt,
            text: "Available",
            textSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.mini),
            fontWeight: FontWeight.w700,
            iconSize: 15,
            textColor: AppTheme.white,
            iconColor: AppTheme.white,
            sizeBetween: 4,
          ),
        ),
      ],
    ),
  );
}
