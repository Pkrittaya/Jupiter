import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jupiter_api/domain/entities/connect_type_power_entity.dart';
import 'package:jupiter_api/domain/entities/connector_entity.dart';
import 'package:jupiter/src/images_asset.dart';

import '../../../../constant_value.dart';
import '../../../../utilities.dart';
import '../../../widgets/index.dart';

class InfoWindowConnectorItem extends StatefulWidget {
  const InfoWindowConnectorItem({
    super.key,
    this.connectorEntity,
    this.connectorType,
  });

  final ConnectorEntity? connectorEntity;
  final ConnectorTypeAndPowerEntity? connectorType;

  @override
  State<InfoWindowConnectorItem> createState() =>
      _InfoWindowConnectorItemState();
}

class _InfoWindowConnectorItemState extends State<InfoWindowConnectorItem> {
  String imageConnector = '';

  String connectorStatusAsset(String connectorStatusActive) {
    switch (connectorStatusActive) {
      case 'AC':
        return ImageAsset.ic_ac_type_lightblue;
      case 'DC':
        return ImageAsset.ic_dc_type_lightblue;
      default:
        return ImageAsset.ic_ac;
    }
  }

  _checkTypeConnector(connectPower, connectType) {
    switch (connectPower) {
      case 'AC':
        if (connectType == 'CS1') {
          imageConnector = ImageAsset.ic_ac_cs1;
        } else if (connectType == 'CS2') {
          imageConnector = ImageAsset.ic_ac_cs2;
        } else {
          imageConnector = ImageAsset.ic_ac_chadeMO;
        }
        break;
      case 'DC':
        if (connectType == 'CS1') {
          imageConnector = ImageAsset.ic_dc_cs1;
        } else if (connectType == 'CS2') {
          imageConnector = ImageAsset.ic_dc_cs2;
        } else {
          imageConnector = ImageAsset.ic_dc_chadeMO;
        }
        break;
      default:
        imageConnector = ImageAsset.ic_ac_chadeMO;
        break;
    }

    return imageConnector;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Expanded(
            child: SvgPicture.asset(
              _checkTypeConnector(widget.connectorType!.connectorPowerType,
                  widget.connectorType!.connectorType),
              width: 20,
              // height: 24,
              // colorFilter: ColorFilter.mode(AppTheme.pttBlue, BlendMode.srcIn),
            ),
          ),
          TextLabel(
            maxLines: 1,
            text: widget.connectorType!.connectorType,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.mini),
            fontWeight: FontWeight.w400,
            // color: AppTheme.pttBlue,
          )
        ],
      ),
    );
  }
}
