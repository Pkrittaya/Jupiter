import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/car_master_entity.dart';
import 'package:jupiter/src/presentation/pages/register/widgets/select_brand_model.dart';
import 'package:jupiter/src/presentation/pages/register/widgets/vehicle_information.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class VerifySuccessAndAddVehicle extends StatefulWidget {
  VerifySuccessAndAddVehicle({
    Key? key,
    required this.isOpenKeyboard,
    required this.listCarFromService,
    required this.licensePlateController,
    required this.provinceController,
    required this.brandTxEditController,
    required this.modelTxEditController,
    required this.clearBrand,
    required this.clearModel,
  }) : super(key: key);

  final bool isOpenKeyboard;
  final List<CarMasterEntity> listCarFromService;
  final TextEditingController licensePlateController;
  final TextEditingController provinceController;
  final TextEditingController brandTxEditController;
  final TextEditingController modelTxEditController;
  final Function() clearBrand;
  final Function() clearModel;

  @override
  State<VerifySuccessAndAddVehicle> createState() =>
      _VerifySuccessAndAddVehicleState();
}

class _VerifySuccessAndAddVehicleState
    extends State<VerifySuccessAndAddVehicle> {
  double spaceLineHeight = 8;
  double heightTitle = 70;
  double heightStep = 64;

  String? carImage;
  bool vehicle = true;

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    double heightAppbar = AppBar().preferredSize.height;
    double heightPage = heightDevice - heightAppbar - 40;
    return Container(
      width: double.infinity,
      height: (heightPage * 0.9) + (widget.isOpenKeyboard ? 40 : 0),
      color: AppTheme.white,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextLabel(
              color: AppTheme.blueDark,
              text: translate('register_page.add_vehicle.title'),
              fontWeight: FontWeight.bold,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.large),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: renderAddFirstCar(),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderAddFirstCar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectBrandModel(
          carMaster: widget.listCarFromService,
          brandTxEditController: widget.brandTxEditController,
          modelTxEditController: widget.modelTxEditController,
          clearBrand: widget.clearBrand,
          clearModel: widget.clearModel,
          carImage: carImage,
        ),
        const SizedBox(height: 20),
        VehicleInform(
          licensePlateController: widget.licensePlateController,
          provinceController: widget.provinceController,
        ),
      ],
    );
  }
}
