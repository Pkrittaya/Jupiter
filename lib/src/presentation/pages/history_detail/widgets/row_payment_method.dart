import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class RowPaymentMethod extends StatefulWidget {
  const RowPaymentMethod({
    Key? key,
    required this.loading,
    required this.value,
    this.fromFleet,
  }) : super(key: key);

  final bool loading;
  final String value;
  final bool? fromFleet;

  @override
  _RowPaymentMethodState createState() => _RowPaymentMethodState();
}

class _RowPaymentMethodState extends State<RowPaymentMethod> {
  String getTypeFromValue() {
    try {
      final splitted = widget.value.split('/');
      if (splitted.length > 1) {
        return splitted[1];
      } else {
        return 'N/A';
      }
    } catch (e) {
      return 'N/A';
    }
  }

  String getDisplayFromValue() {
    try {
      final splitted = widget.value.split('/');
      if (splitted.length > 0) {
        return splitted[0].substring(splitted[0].length - 4);
      } else if (splitted[0].length == 4) {
        return splitted[0];
      } else {
        return 'N/A';
      }
    } catch (e) {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextLabel(
          maxLines: 1,
          text: translate("receipt_page.payment"),
          fontSize: Utilities.sizeFontWithDesityForDisplay(
            context,
            20,
          ),
          color: AppTheme.black40,
          fontWeight: FontWeight.w400,
        ),
        const Expanded(child: SizedBox()),
        Container(child: imgCardFromType()),
        const SizedBox(
          width: 12,
        ),
        TextLabel(
          maxLines: 1,
          textAlign: TextAlign.end,
          text: getDisplayFromValue(),
          fontSize: Utilities.sizeFontWithDesityForDisplay(
            context,
            20,
          ),
          color: AppTheme.black,
          fontWeight: FontWeight.w400,
        )
      ],
    );
  }

  Widget imgCardFromType() {
    if (widget.loading) {
      return Container(
        width: 24,
        height: 24,
      );
    } else {
      if (widget.fromFleet == true) {
        return SvgPicture.asset(
          ImageAsset.card_default_logo,
          width: 24,
          height: 24,
        );
      } else {
        return Utilities.assetCreditCard(
            cardBrand: getTypeFromValue(), width: 24, height: 24);
      }
    }
  }
}
