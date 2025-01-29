import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/presentation/widgets/button.dart';

import '../../../../route_names.dart';

class ButtonAddVehicle extends StatefulWidget {
  const ButtonAddVehicle({
    Key? key,
  }) : super(key: key);

  @override
  _ButtonAddVehicleState createState() => _ButtonAddVehicleState();
}

class _ButtonAddVehicleState extends State<ButtonAddVehicle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.11,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Button(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: AppTheme.blueD,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(200)),
          ),
        ),
        text: translate("ev_information_page.add_ev_car_button"),
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.ev_information_add);
        },
        textColor: Colors.white,
      ),
    );
  }
}
