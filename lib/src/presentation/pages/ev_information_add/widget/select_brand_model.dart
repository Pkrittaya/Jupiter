import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter_api/domain/entities/car_master_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/ev_information_add/widget/modal_search_select.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SelectBrandModel extends StatefulWidget {
  SelectBrandModel(
      {Key? key,
      this.carMaster,
      required this.brandSelect,
      this.brandTxEditController,
      this.modelTxEditController,
      this.carImage,
      required this.canEdit,
      required this.validateBrand,
      required this.validateModel,
      required this.onValidate})
      : super(key: key);

  final CarMasterEntity brandSelect;
  final TextEditingController? brandTxEditController;
  final TextEditingController? modelTxEditController;
  final List<CarMasterEntity>? carMaster;
  final String? carImage;
  final bool canEdit;
  final bool validateBrand;
  final bool validateModel;
  final Function() onValidate;

  @override
  _SelectBrandModelState createState() => _SelectBrandModelState();
}

class _SelectBrandModelState extends State<SelectBrandModel> {
  CarMasterEntity? brandSelectInWidget;
  TextEditingController modelTextEditerController = TextEditingController();
  TextEditingController brandTextEditerController = TextEditingController();
  bool brandenable = true;

  String? modelimg;

  List<String> nullModal = [];

  int indexBrand = 0;
  String beforeBrand = '';
  int beforeIndexBrand = 0;
  int indexModel = 0;
  String beforeModel = '';
  int beforeIndexModel = 0;

  Color getColorStatus(String value) {
    switch (value) {
      case 'DEFAULT_BORDER':
        return AppTheme.borderGray;
      case 'DEFAULT_FIELD':
        return AppTheme.white;
      case 'VALIDATE_BORDER':
        return AppTheme.red;
      case 'VALIDATE_FIELD':
        return AppTheme.red.withOpacity(0.1);
      default:
        return AppTheme.grayF1F5F9;
    }
  }

  void initEditWidget() {
    if (widget.canEdit != true) {
      brandenable = false;
      modelimg = widget.carImage;
    } else {
      if (widget.brandTxEditController!.text.isNotEmpty &&
          widget.modelTxEditController!.text.isNotEmpty) {
        brandenable = true;
        modelimg = widget.carImage;
        Future.delayed(Duration(milliseconds: 2000), () {
          if (mounted) {
            setState(() {
              brandSelectInWidget = widget.brandSelect;
            });
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initEditWidget();
  }

  void initialIndexBrandModel(String type) {
    switch (type) {
      case 'BRAND':
        beforeBrand = widget.brandTxEditController?.text ?? '';
        beforeIndexBrand = widget.carMaster!.indexWhere(
            (item) => item.brand == widget.brandTxEditController?.text);
        if (beforeIndexBrand < 0) {
          beforeIndexBrand = 0;
        }
        indexBrand = beforeIndexBrand;
        break;
      case 'MODEL':
        beforeModel = widget.modelTxEditController?.text ?? '';
        beforeIndexModel = brandSelectInWidget!.model.indexWhere(
            (item) => item.name == widget.modelTxEditController?.text);
        if (beforeIndexModel < 0) {
          beforeIndexModel = 0;
        }
        indexModel = beforeIndexModel;
        break;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  void onChangeBrandModel(int index, List<dynamic> listItem, String type) {
    switch (type) {
      case 'BRAND':
        beforeBrand = listItem[index].brand ?? '';
        beforeIndexBrand = index;
        break;
      case 'MODEL':
        beforeModel = listItem[index].name ?? '';
        beforeIndexModel = index;
        break;
    }
  }

  void onDoneBrandModel(List<dynamic> listItem, String type) {
    switch (type) {
      case 'BRAND':
        if (listItem.length > 0) {
          /** start ตรวจสอบการเลือก brand ใหม่ **/
          if (widget.brandTxEditController?.text != beforeBrand) {
            widget.modelTxEditController?.text = '';
            indexModel = 0;
            beforeModel = '';
            beforeIndexModel = 0;
            modelimg = '';
          }
          /** end ตรวจสอบการเลือก brand ใหม่ **/

          indexBrand = beforeIndexBrand;
          brandSelectInWidget = listItem[indexBrand];
          if (widget.brandTxEditController?.text == '') {
            widget.brandTxEditController?.text =
                listItem[indexBrand].brand ?? '';
          }
          beforeModel = brandSelectInWidget?.brand ?? '';
          widget.brandTxEditController?.text = beforeModel;
        }
        break;
      case 'MODEL':
        if (listItem.length > 0) {
          indexModel = beforeIndexModel;
          if (widget.modelTxEditController?.text == '') {
            widget.modelTxEditController?.text =
                listItem[indexModel].name ?? '';
          }
          beforeModel = listItem[indexModel].name ?? '';
          widget.modelTxEditController?.text = beforeModel;
          modelimg = listItem[indexModel].image;
        }
        break;
    }

    // setState(() {});
    widget.onValidate();
    Navigator.of(context).pop();
  }

  void whenCompleteBrandModel() {
    setState(() {});
    try {
      FocusScope.of(context).requestFocus(new FocusNode());
    } catch (e) {}
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
                      ? InkWell(
                          onTap: () {
                            if (widget.canEdit) {
                              if ((widget.carMaster ?? []).length > 0) {
                                initialIndexBrandModel('BRAND');
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(12))),
                                  builder: (BuildContext context) {
                                    return ModalSearchSelect(
                                      type: 'BRAND',
                                      listItem: widget.carMaster ?? [],
                                      initialIndex: indexBrand,
                                      onChange: onChangeBrandModel,
                                      onDoneModal: onDoneBrandModel,
                                      itemSelect: beforeBrand,
                                    );
                                  },
                                ).whenComplete(whenCompleteBrandModel);
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: getColorStatus(widget.validateBrand
                                  ? 'VALIDATE_FIELD'
                                  : 'DEFAULT_FIELD'),
                              border: Border.all(
                                width: 1,
                                color: getColorStatus(widget.validateBrand
                                    ? 'VALIDATE_BORDER'
                                    : 'DEFAULT_BORDER'),
                              ),
                            ),
                            child: widget.brandTxEditController!.text == ''
                                ? TextLabel(
                                    text: translate(
                                        'ev_information_add_page.select_brand_model.brand'),
                                    textAlign: TextAlign.center,
                                    color: AppTheme.black60,
                                  )
                                : TextLabel(
                                    text: widget.brandTxEditController!.text,
                                    textAlign: TextAlign.center,
                                    color: AppTheme.blueDark,
                                  ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppTheme.black60.withOpacity(0.1),
                            border: Border.all(
                              width: 1,
                              color: AppTheme.borderGray,
                            ),
                          ),
                          child: TextLabel(
                            text: widget.brandTxEditController!.text,
                            textAlign: TextAlign.center,
                            color: AppTheme.blueDark,
                          ),
                        ),
                ),
              ),
              // Model
              Expanded(
                child: Skeletonizer(
                  enabled: (brandSelectInWidget?.model.length ?? 0) == 0 &&
                      widget.canEdit &&
                      widget.brandTxEditController!.text.isNotEmpty &&
                      widget.modelTxEditController!.text.isNotEmpty,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: brandenable
                        ? InkWell(
                            onTap: () {
                              if (widget.canEdit) {
                                if ((brandSelectInWidget?.model.length ?? 0) >
                                    0) {
                                  initialIndexBrandModel('MODEL');
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(12))),
                                    builder: (BuildContext context) {
                                      return ModalSearchSelect(
                                        type: 'MODEL',
                                        listItem:
                                            brandSelectInWidget?.model ?? [],
                                        initialIndex: indexModel,
                                        onChange: onChangeBrandModel,
                                        onDoneModal: onDoneBrandModel,
                                        itemSelect: beforeModel,
                                      );
                                    },
                                  ).whenComplete(whenCompleteBrandModel);
                                }
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: ((widget.brandTxEditController?.text !=
                                            '') &&
                                        ((brandSelectInWidget?.model ?? [])
                                                .length >
                                            0))
                                    ? getColorStatus(widget.validateModel
                                        ? 'VALIDATE_FIELD'
                                        : 'DEFAULT_FIELD')
                                    : AppTheme.black40.withOpacity(0.1),
                                border: Border.all(
                                  width: 1,
                                  color:
                                      widget.brandTxEditController?.text != ''
                                          ? getColorStatus(widget.validateModel
                                              ? 'VALIDATE_BORDER'
                                              : 'DEFAULT_BORDER')
                                          : AppTheme.borderGray,
                                ),
                              ),
                              child: widget.modelTxEditController!.text == ''
                                  ? TextLabel(
                                      text: translate(
                                          'ev_information_add_page.select_brand_model.model'),
                                      textAlign: TextAlign.center,
                                      color: AppTheme.black60,
                                    )
                                  : TextLabel(
                                      text: widget.modelTxEditController!.text,
                                      textAlign: TextAlign.center,
                                      color: AppTheme.blueDark,
                                    ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: AppTheme.black60.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1,
                                color: AppTheme.borderGray,
                              ),
                            ),
                            child: TextLabel(
                              text: widget.modelTxEditController!.text,
                              textAlign: TextAlign.center,
                              color: AppTheme.blueDark,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
