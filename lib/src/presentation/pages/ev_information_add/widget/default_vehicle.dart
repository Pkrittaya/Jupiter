import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/presentation/widgets/tootip_information.dart';
import 'package:jupiter/src/utilities.dart';

class DefaultInformation extends StatefulWidget {
  DefaultInformation(
      {super.key, required this.onChanged, this.setdefault, this.editDefault});
  final void Function(bool) onChanged;
  final bool? setdefault;
  final bool? editDefault;

  @override
  State<DefaultInformation> createState() => _DefaultInformationState();
}

class _DefaultInformationState extends State<DefaultInformation> {
  bool defaultVehicle = false;

  @override
  Widget build(BuildContext context) {
    if (widget.editDefault!) {
      defaultVehicle = widget.setdefault!;
    }
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextLabel(
                color: AppTheme.blueDark,
                text: translate(
                    "ev_information_add_page.default_vehicle.set_default_vehicles"),
                fontSize: Utilities.sizeFontWithDesityForDisplay(context, 20),
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                width: 8,
              ),
              TooltipInformation(
                message: translate("ev_information_add_page.information"),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                width: 50,
                height: 30,
                child: Transform.scale(
                  scale: 0.7,
                  alignment: Alignment.centerLeft,
                  child: CupertinoSwitch(
                    value: defaultVehicle,
                    activeColor: AppTheme.blueD,
                    onChanged: (value) {
                      defaultVehicle = value;
                      widget.onChanged(value);
                      setState(() {});
                    },
                  ),
                ),
              ),
              TextLabel(
                text: translate(
                    "ev_information_add_page.default_vehicle.default"),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.little),
                fontWeight: FontWeight.w700,
                color: defaultVehicle ? AppTheme.blueD : AppTheme.gray9CA3AF,
              ),
            ],
          )
        ],
      ),
    );
  }
}
