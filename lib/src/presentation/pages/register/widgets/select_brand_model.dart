import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter_api/domain/entities/car_master_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_input_form.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';

class SelectBrandModel extends StatefulWidget {
  const SelectBrandModel({
    Key? key,
    this.carMaster,
    this.brandTxEditController,
    this.modelTxEditController,
    required this.clearBrand,
    required this.clearModel,
    this.carImage,
  }) : super(key: key);

  final TextEditingController? brandTxEditController;
  final TextEditingController? modelTxEditController;
  final Function() clearBrand;
  final Function() clearModel;
  final List<CarMasterEntity>? carMaster;
  final String? carImage;

  @override
  _SelectBrandModelState createState() => _SelectBrandModelState();
}

class _SelectBrandModelState extends State<SelectBrandModel> {
  CarMasterEntity? brandSelect;
  bool showListModel = true;
  TextEditingController modelTextEditerController = TextEditingController();
  TextEditingController brandTextEditerController = TextEditingController();
  bool modelenable = false;
  bool brandenable = true;

  String? modelimg;

  List<String> nullModal = [];

  void initEditWidget() {
    if (widget.brandTxEditController!.text.isNotEmpty &&
        widget.modelTxEditController!.text.isNotEmpty) {
      brandenable = false;
      modelimg = widget.carImage;
    }
  }

  @override
  void initState() {
    super.initState();
    initEditWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppTheme.white,
        border: Border.all(color: AppTheme.borderGray),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            child: modelimg != null && modelimg!.isNotEmpty
                ? ImageNetworkJupiter(
                    url: modelimg!,
                    width: 200,
                    height: 200,
                  )
                // Image.network(
                //     modelimg!,
                //     width: 200,
                //     height: 200,
                //   )
                : SvgPicture.asset(
                    ImageAsset.vehicle_non_img,
                    width: 200,
                    height: 200,
                  ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // Brand
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: brandenable
                          ? Autocomplete(
                              fieldViewBuilder: (context,
                                  autobrandTxEditController,
                                  brandFocusNode,
                                  onBrandSubmitted) {
                                // autobrandTxEditController.text =
                                //     widget.brandTxEditController!.text;
                                brandTextEditerController =
                                    autobrandTxEditController;

                                autobrandTxEditController.selection =
                                    TextSelection.collapsed(
                                        offset: autobrandTxEditController
                                            .text.length);
                                return TextInputForm(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      brandTextEditerController.text != ''
                                          ? 30
                                          : 40,
                                      20,
                                      0,
                                      20),
                                  enabled: brandenable,
                                  key: Key(translate(
                                      'ev_information_add_page.select_brand_model.brand')),
                                  textAlign: TextAlign.center,
                                  focusNode: brandFocusNode,
                                  controller: autobrandTxEditController,
                                  hintText: translate(
                                      'ev_information_add_page.select_brand_model.brand'),
                                  hintStyle: const TextStyle(
                                    color: AppTheme.black60,
                                  ),
                                  style: TextStyle(
                                    color: AppTheme.blueDark,
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, 20),
                                  ),
                                  fillColor: AppTheme.white,
                                  borderColor: AppTheme.borderGray,
                                  suffixIcon: brandTextEditerController.text !=
                                          ''
                                      ? IconButton(
                                          icon: Material(
                                            color: AppTheme.black20,
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            child: Icon(
                                              Icons.close_outlined,
                                              color: AppTheme.white,
                                              size: 16,
                                            ),
                                          ),
                                          onPressed: () {
                                            widget.clearBrand;
                                            brandTextEditerController.text = '';
                                            modelTextEditerController.text = '';
                                            modelimg = '';
                                            modelenable = false;
                                            setState(() {});
                                          },
                                        )
                                      : SizedBox(),
                                  onChanged: (val) {
                                    if (val == '') {
                                      modelTextEditerController.text = '';
                                      modelenable = false;
                                      modelimg = '';
                                      widget.brandTxEditController!.text = '';
                                      widget.modelTxEditController!.text = '';
                                    } else {
                                      modelenable = true;

                                      brandSelect = widget.carMaster!
                                          .firstWhere((option) =>
                                              option.brand.toLowerCase() ==
                                              val!.toLowerCase());

                                      // setState(() {});
                                    }
                                  },
                                  validator: (text) {
                                    if (text == null || text == '') {
                                      return translate(
                                          'ev_information_add_page.validate.required');
                                    } else {
                                      return '';
                                    }
                                  },
                                );
                              },
                              optionsBuilder:
                                  (TextEditingValue brandEditingValue) {
                                return widget.carMaster!
                                    .where((CarMasterEntity option) {
                                  return option.brand.toLowerCase().contains(
                                      brandEditingValue.text.toLowerCase());
                                });
                              },
                              optionsViewBuilder: (BuildContext context,
                                  AutocompleteOnSelected onSelected,
                                  Iterable options) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    elevation: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: 200,
                                      width: 168,
                                      child: ListView.separated(
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const Divider(
                                                    color: AppTheme.black20,
                                                  ),
                                          padding: EdgeInsets.all(10.0),
                                          itemCount: options.length,
                                          itemBuilder: (context, index) {
                                            final opt =
                                                options.elementAt(index);
                                            return InkWell(
                                              child: Container(
                                                child: TextLabel(
                                                  text: opt.brand,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppTheme.blueDark,
                                                ),
                                              ),
                                              onTap: () {
                                                modelenable = true;
                                                onSelected(opt.brand);
                                                brandSelect = opt;
                                                widget.brandTxEditController!
                                                    .text = opt.brand;
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                            );
                                          }),
                                    ),
                                  ),
                                );
                              },
                            )
                          : TextLabel(
                              text: widget.brandTxEditController!.text,
                              textAlign: TextAlign.center,
                              color: AppTheme.blueDark,
                            ))),
              // Model
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: brandenable
                          ? Autocomplete(
                              fieldViewBuilder: (context,
                                  automodelTxEditController,
                                  modelFocusNode,
                                  onmodelSubmitted) {
                                // automodelTxEditController.text =
                                //     widget.modelTxEditController!.text;
                                modelTextEditerController =
                                    automodelTxEditController;
                                modelTextEditerController.selection =
                                    TextSelection.collapsed(
                                        offset: modelTextEditerController
                                            .text.length);
                                return TextInputForm(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      modelTextEditerController.text != ''
                                          ? 30
                                          : 40,
                                      20,
                                      0,
                                      20),
                                  enabled: modelenable,
                                  key: Key(translate(
                                      'ev_information_add_page.select_brand_model.model')),
                                  textAlign: TextAlign.center,
                                  focusNode: modelFocusNode,
                                  controller: automodelTxEditController,
                                  hintText: translate(
                                      'ev_information_add_page.select_brand_model.model'),
                                  hintStyle: const TextStyle(
                                    color: AppTheme.black60,
                                  ),
                                  style: TextStyle(
                                    color: AppTheme.blueDark,
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, 20),
                                  ),
                                  fillColor: AppTheme.white,
                                  borderColor: AppTheme.borderGray,
                                  suffixIcon: modelenable &&
                                          modelTextEditerController.text != ''
                                      ? IconButton(
                                          icon: Material(
                                            color: AppTheme.black20,
                                            borderRadius:
                                                BorderRadius.circular(200),
                                            child: Icon(
                                              Icons.close_outlined,
                                              color: AppTheme.white,
                                              size: 16,
                                            ),
                                          ),
                                          onPressed: () {
                                            widget.clearModel;
                                            modelimg = '';
                                            modelTextEditerController.text = '';
                                            setState(() {});
                                          },
                                        )
                                      : SizedBox(),
                                  onChanged: (val) {},
                                  validator: (text) {
                                    if (text == null || text == '') {
                                      return translate(
                                          'ev_information_add_page.validate.required');
                                    } else {
                                      return '';
                                    }
                                  },
                                );
                              },
                              optionsBuilder: (modelEditingValue) {
                                if (brandSelect == null) {
                                  return nullModal.where((option) => option
                                      .toLowerCase()
                                      .contains(modelEditingValue.text
                                          .toLowerCase()));
                                } else {
                                  return brandSelect!.model.where((option) =>
                                      option.name.toLowerCase().contains(
                                          modelEditingValue.text
                                              .toLowerCase()));
                                }
                              },
                              optionsViewBuilder: (BuildContext context,
                                  AutocompleteOnSelected onSelected,
                                  Iterable options) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    elevation: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: 200,
                                      width: 168,
                                      child: ListView.separated(
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const Divider(
                                                    color: AppTheme.black20,
                                                  ),
                                          padding: EdgeInsets.all(10.0),
                                          itemCount: options.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final opt =
                                                options.elementAt(index);

                                            return InkWell(
                                              child: Container(
                                                child: TextLabel(
                                                  text: opt.name,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppTheme.blueDark,
                                                ),
                                              ),
                                              onTap: () {
                                                onSelected(opt.name);
                                                FocusScope.of(context)
                                                    .unfocus();
                                                modelimg = opt.image;
                                                widget.modelTxEditController!
                                                    .text = opt.name;
                                              },
                                            );
                                          }),
                                    ),
                                  ),
                                );
                              },
                            )
                          : TextLabel(
                              text: widget.modelTxEditController!.text,
                              textAlign: TextAlign.center,
                              color: AppTheme.blueDark,
                            ))),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
