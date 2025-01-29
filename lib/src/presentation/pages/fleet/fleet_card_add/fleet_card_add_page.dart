import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/fleet/cubit/fleet_cubit.dart';
import 'package:jupiter/src/presentation/widgets/button.dart';
import 'package:jupiter/src/presentation/widgets/button_close_keyboard.dart';
import 'package:jupiter/src/presentation/widgets/card_no_formatter.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/presentation/widgets/modal_select_list.dart';
import 'package:jupiter/src/presentation/widgets/unfocus_area.dart';
import 'package:jupiter/src/utilities.dart';

import '../../../../firebase_log.dart';

class FleetCardAddPage extends StatefulWidget {
  const FleetCardAddPage({super.key});

  @override
  State<FleetCardAddPage> createState() => _FleetCardAddPageState();
}

class _FleetCardAddPageState extends State<FleetCardAddPage> {
  bool loadingPage = true;
  int cardNoLength = 19;

  /** modal Month Year **/
  int indexMonth = 0;
  String beforeMonth = '';
  int beforeIndexMonth = 0;
  int indexYear = 0;
  String beforeYear = '';
  int beforeIndexYear = 0;
  List<dynamic> monthList = List.empty(growable: true);
  List<dynamic> yearList = List.empty(growable: true);
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  TextEditingController fleetNoController = TextEditingController();
  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
  }

  String getTextMonthFromIndex() {
    return monthList[indexMonth]['text'];
  }

  String getTextYearFromIndex() {
    return yearList[indexYear]['text'];
  }

  bool checkInputEmpty() {
    var verify = false;
    if (fleetNoController.text.isNotEmpty &&
        fleetNoController.text.length == cardNoLength &&
        monthController.text.isNotEmpty &&
        yearController.text.isNotEmpty) {
      verify = true;
    } else {
      verify = false;
    }
    setState(() {});
    return verify;
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  void onPressdSaveAddVehicle(
    BuildContext widgetContext,
  ) {
    if (checkInputEmpty()) {
      try {
        BlocProvider.of<FleetCubit>(widgetContext).verifyFleetCard(
            cardNo: fleetNoController.text.replaceAll(' ', ''),
            expiredDate: '${monthController.text}/${yearController.text}');
      } catch (e) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (loadingPage) {
            setState(() {
              loadingPage = false;
            });
            BlocProvider.of<FleetCubit>(context).resetStateFleet();
          }
        });
      }
    }
  }

  void initialMonth() {
    FocusScope.of(context).unfocus();
    /** Make Month **/
    monthList.clear();
    for (var i = 1; i <= 12; i++) {
      monthList.add({
        'value': '${i.toString().padLeft(2, '0')}',
        'text': '${i.toString().padLeft(2, '0')}',
      });
    }
    /** Make Month **/
    if (monthController.text == '') {
      beforeMonth = monthList[0]['value'];
      indexMonth = 0;
    } else {
      beforeMonth = monthController.text;
      indexMonth = indexMonth;
    }
  }

  void onChangeMonth(int index) {
    beforeMonth = monthList[index]['value'];
    beforeIndexMonth = index;
  }

  void onDoneModalMonth() {
    monthController.text = beforeMonth;
    indexMonth = beforeIndexMonth;

    if (monthController.text == '') {
      beforeMonth = monthList[0]['value'];
      monthController.text = beforeMonth;
      indexMonth = 0;
    }

    setState(() {});
    Navigator.of(context).pop();
  }

  void initialYear() {
    FocusScope.of(context).unfocus();
    /** Make Year **/
    yearList.clear();
    for (var i = 0; i < 50; i++) {
      var year = DateTime.now().year + i;

      yearList.add({
        'value': '$year',
        'text': '$year',
      });
    }
    /** Make Year **/

    if (yearController.text == '') {
      beforeYear = yearList[0]['value'];
      indexYear = 0;
    } else {
      beforeYear = yearController.text;
      indexYear = indexYear;
    }
  }

  void onChangYear(int index) {
    beforeYear = yearList[index]['value'];
    beforeIndexYear = index;
  }

  void onDoneModalYear() {
    yearController.text = beforeYear;
    indexYear = beforeIndexYear;

    if (yearController.text == '') {
      beforeYear = yearList[0]['value'];
      yearController.text = beforeYear;
      indexYear = 0;
    }

    setState(() {});
    Navigator.of(context).pop();
  }

  void whenComplete() {
    setState(() {});
    try {
      FocusScope.of(context).requestFocus(new FocusNode());
    } catch (e) {}
  }

  void actionFleetVerifyLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionFleetVerifySuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        onPressedBackButton();
      }
    });
  }

  void actionFleetVerifyFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: state.message ?? translate('alert.description.default'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  void actionDefault() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.white,
          bottomOpacity: 0.0,
          elevation: 0.0,
          iconTheme: const IconThemeData(
            color: AppTheme.blueDark, //change your color here
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
            onPressed: onPressedBackButton,
          ),
          centerTitle: true,
          title: TextLabel(
            text: translate("fleet_page.add_fleet.title"),
            color: AppTheme.blueDark,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.title),
            fontWeight: FontWeight.w700,
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: AppTheme.white,
              height: MediaQuery.of(context).size.height * 0.9,
              padding: const EdgeInsets.all(16),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: MultiBlocListener(
                    listeners: [
                      BlocListener<FleetCubit, FleetState>(
                        listener: (context, state) {
                          switch (state.runtimeType) {
                            case FleetVerifyLoading:
                              actionFleetVerifyLoading();
                              break;
                            case FleetVerifySuccess:
                              actionFleetVerifySuccess();
                              break;
                            case FleetVerifyFailure:
                              actionFleetVerifyFailure(state);
                              break;
                            default:
                              actionDefault();
                              break;
                          }
                        },
                      ),
                    ],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // FLEET CARD NO
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextLabel(
                                color: AppTheme.blueDark,
                                text: translate(
                                    "fleet_page.add_fleet.fleet_no.fleet_no"),
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.big),
                                fontWeight: FontWeight.w700,
                              ),
                              const SizedBox(height: 10),
                              TextInputForm(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CardNumberFormatter(),
                                ],
                                maxLength: cardNoLength,
                                keyboardType: TextInputType.number,
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 12, 16, 12),
                                controller: fleetNoController,
                                hintText: translate(
                                    "fleet_page.add_fleet.fleet_no.card_no"),
                                hintStyle: TextStyle(
                                  color: AppTheme.black60,
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.big),
                                ),
                                style: TextStyle(
                                    color: AppTheme.blueDark,
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.big)),
                                fillColor: AppTheme.white,
                                borderColor: AppTheme.borderGray,
                                onTap: () {},
                                onChanged: (val) {
                                  checkInputEmpty();
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // EXPIREDATE
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextLabel(
                                color: AppTheme.blueDark,
                                text: translate(
                                    "fleet_page.add_fleet.expired_date.expired_date"),
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.big),
                                fontWeight: FontWeight.w700,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //************* Month ***************//
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        initialMonth();
                                        showModalBottomSheet(
                                          context: context,
                                          // enableDrag: false,
                                          // isDismissible: false,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(12))),
                                          builder: (BuildContext context) {
                                            return ModalSelectList(
                                              type: 'MONTH',
                                              listItem: monthList,
                                              initialIndex: indexMonth,
                                              onChange: onChangeMonth,
                                              onDoneModal: onDoneModalMonth,
                                            );
                                          },
                                        ).whenComplete(whenComplete);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          border: Border.all(
                                              color: AppTheme.borderGray),
                                        ),
                                        height: 48,
                                        alignment: Alignment.centerLeft,
                                        child: TextLabel(
                                          text: monthController.text != ''
                                              ? getTextMonthFromIndex()
                                              : translate(
                                                  "fleet_page.add_fleet.expired_date.month"),
                                          color: monthController.text != ''
                                              ? AppTheme.blueDark
                                              : AppTheme.black60,
                                          fontSize: Utilities
                                              .sizeFontWithDesityForDisplay(
                                                  context, AppFontSize.big),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  //**************** Year ***************//
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        initialYear();
                                        showModalBottomSheet(
                                          context: context,
                                          // enableDrag: false,
                                          // isDismissible: false,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(12))),
                                          builder: (BuildContext context) {
                                            return ModalSelectList(
                                              type: 'MONTH',
                                              listItem: yearList,
                                              initialIndex: indexYear,
                                              onChange: onChangYear,
                                              onDoneModal: onDoneModalYear,
                                            );
                                          },
                                        ).whenComplete(whenComplete);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          border: Border.all(
                                              color: AppTheme.borderGray),
                                        ),
                                        height: 48,
                                        alignment: Alignment.centerLeft,
                                        child: TextLabel(
                                          text: yearController.text != ''
                                              ? getTextYearFromIndex()
                                              : translate(
                                                  "fleet_page.add_fleet.expired_date.year"),
                                          color: yearController.text != ''
                                              ? AppTheme.blueDark
                                              : AppTheme.black60,
                                          fontSize: Utilities
                                              .sizeFontWithDesityForDisplay(
                                                  context, AppFontSize.big),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: (MediaQuery.of(context).size.height * 0.11) +
                              (MediaQuery.of(context).viewInsets.bottom > 0
                                  ? 40
                                  : 0),
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: AppTheme.white,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.11,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Button(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      backgroundColor: checkInputEmpty()
                          ? AppTheme.blueD
                          : AppTheme.gray9CA3AF,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(200)),
                      ),
                    ),
                    text: translate('ev_information_add_page.button_save'),
                    onPressed: () {
                      if (checkInputEmpty()) {
                        onPressdSaveAddVehicle(context);
                      }
                    },
                    textColor: Colors.white,
                  ),
                ),
                ButtonCloseKeyboard(contextPage: context)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
