import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';

import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in_device/widgets/charger_device_data.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in_device/widgets/charger_type.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../firebase_log.dart';
import '../../../../route_names.dart';

class JupiterChargingCheckInDevicePage extends StatefulWidget {
  const JupiterChargingCheckInDevicePage({super.key});

  @override
  State<JupiterChargingCheckInDevicePage> createState() =>
      _JupiterChargingCheckInDevicePageState();
}

class _JupiterChargingCheckInDevicePageState
    extends State<JupiterChargingCheckInDevicePage> {
  bool selectConnecter = false;
  bool verify = false;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppTheme.blueLight,
          iconTheme: const IconThemeData(
            color: AppTheme.blueDark, //change your color here
          ),
          title: Center(
            child: TextLabel(
              color: AppTheme.blueDark,
              text: 'Charging',
              fontWeight: FontWeight.w700,
              fontSize: Utilities.sizeFontWithDesityForDisplay(context, 32),
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
            color: AppTheme.blueLight,
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextLabel(
                      text: 'PTT Chatuchak',
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.large),
                      fontWeight: FontWeight.w700,
                      color: AppTheme.blueDark,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const ChargerDeviceData(
                  charger_name: 'ABCCharger - jupiter 001',
                  total_connector: '3',
                  connector_index: '123456',
                ),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.only(
                        top: 40, left: 40, right: 40, bottom: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImageAsset.charging_connecter,
                            width: 200,
                          ),
                          const SizedBox(height: 10),
                          TextLabel(
                            textAlign: TextAlign.center,
                            text: translate(
                                "check_in_page.check_in_device.connector"),
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.large),
                            fontWeight: FontWeight.w500,
                            color: AppTheme.blueDark,
                          ),
                          const SizedBox(height: 20),
                          TextLabel(
                            textAlign: TextAlign.center,
                            text: translate(
                                "check_in_page.check_in_device.description"),
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.normal),
                            fontWeight: FontWeight.w400,
                            color: AppTheme.black40,
                          ),
                        ])),
                SizedBox(
                  height: 200,
                  child: ChargerType(
                    onChanged: (p0) {
                      verify = true;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 120),
              ],
            )),
      ),
      floatingActionButton: Container(
        color: AppTheme.blueLight,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: InkWell(
            child: Container(
              height: 100,
              width: 240,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: verify ? AppTheme.blueD : AppTheme.black40,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextLabel(
                text:
                    translate("check_in_page.check_in_device.button_continue"),
                fontSize: 18,
                color: AppTheme.white,
              ),
            ),
            onTap: () async {
              // verify = selectConnecter;
              if (verify) {
                Navigator.pushNamed(
                    context, RouteNames.jupiter_charging_check_in);
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
