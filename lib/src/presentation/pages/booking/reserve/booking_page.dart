import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/jupiter_prefs_and_app_data.dart';
import 'package:jupiter_api/data/data_models/request/create_reserve_form.dart';
import 'package:jupiter_api/data/data_models/request/payment_type_form.dart';
import 'package:jupiter_api/domain/entities/charger_entity.dart';
import 'package:jupiter_api/domain/entities/connector_entity.dart';
import 'package:jupiter_api/domain/entities/credit_card_entity.dart';
import 'package:jupiter_api/domain/entities/list_reserve_of_connector_entity.dart';
import 'package:jupiter_api/domain/entities/reserve_slot_entity.dart';
import 'package:jupiter_api/domain/entities/station_details_entity.dart';
import 'package:jupiter/src/firebase_log.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/booking/cubit/booking_cubit.dart';
import 'package:jupiter/src/presentation/pages/booking/reserve/widgets/booking_button_bottom.dart';
import 'package:jupiter/src/presentation/pages/booking/reserve/widgets/booking_modal_confirm.dart';
import 'package:jupiter/src/presentation/pages/booking/reserve/widgets/booking_select_date.dart';
import 'package:jupiter/src/presentation/pages/booking/reserve/widgets/booking_select_detail.dart';
import 'package:jupiter/src/presentation/pages/booking/reserve/widgets/booking_station_name.dart';
import 'package:jupiter/src/presentation/pages/booking/reserve/widgets/modal_select_payment.dart';
import 'package:jupiter/src/presentation/pages/booking/reserve_receipt/booking_receipt_page.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/route_names.dart';
import 'package:jupiter/src/utilities.dart';

class TypeOfButtonSelectTime {
  static const String selectEnd = 'SELECTEND';
  static const String selectStart = 'SELECTSTART';
  static const String selected = 'SELECTED';
}

class BookingPage extends StatefulWidget {
  const BookingPage({
    required this.stationData,
    required this.charger,
    required this.connector,
  });

  final ChargerEntity? charger;
  final ConnectorEntity? connector;
  final StationDetailEntity? stationData;

  @override
  State<StatefulWidget> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // BOOKING DATA AT DATE SELECTED
  ReserveSlotEntity? bookingSelect;

  bool canBook = false;
  List<List<dynamic>> dataSlot = [];
  int dateWordIndex = 1;
  String description = 'Description for Booking This Table !!!';
  // COLOR SELECTED
  Color disableButton = AppTheme.black20.withOpacity(0.3);

  bool emptyBookingTable = false;
  String endDateSelectedText = 'N/A';
  String endTimeSelectedText = '00:00';
  bool errorPage = false;
  double heightButtonBottom = 160;
  int idSelectedPayment = 0;
  // SELECT DATE
  int indexDate = 0;

  int? indexTimeEnd = null;
  int? indexTimeStart = null;
  bool isCheck = false;
  bool isNextDayConnect = false;
  bool isShowModal = false;
  double itemColumn = 12;
  JupiterPrefsAndAppData jupiterPrefsAndAppData = getIt();
  // PAYMENT
  List<CreditCardEntity>? listCardData;

  // RESERVE FROM API
  List<ListReserveOfConnectorEntity>? listReserveOfConnectorData;

  bool loadingPage = false;
  bool loadingPayment = false;
  Color reserveButton = AppTheme.blueD.withOpacity(0.9);
  // SELECT TIME
  int rowItem = 0;

  int? rowTimeEnd = null;
  int? rowTimeStart = null;
  CreditCardEntity selectedPayment = CreditCardEntity(
    display: '',
    cardBrand: '',
    cardExpired: '',
    cardHashing: '',
    type: '',
    name: '',
    defalut: false,
  );

  double sizePaddingHorizontal = 16;
  // SIZE
  double sizeStartTable = 50;

  String startDateSelectedText =
      DateFormat('dd/MM/yyyy').format(DateTime.now());

  String startTimeSelectedText = '00:00';
  String statusSelectTime = TypeOfButtonSelectTime.selectStart;
  // CHECKER
  Timer? timer;

  DateTime timerChecker = DateTime.now();
  int totalTimeSelectedText = 0;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    FirebaseLog.logPage(this);
    initConnectorData();
    listenDisableButtonSelectItem();
    checkEmptyBookingTable();
    debugPrint('stationData : ${widget.stationData}');
    debugPrint('connector : ${widget.charger}');
    debugPrint('connector : ${widget.connector}');
    BlocProvider.of<BookingCubit>(context).fetchListReserveFromDate(
      stationId: widget.stationData?.stationId ?? '',
      chargerId: widget.charger?.chargerId ?? '',
      connectorId: widget.connector?.connectorId ?? '',
      connectorQrCode: widget.connector?.connectorQrCode ?? '',
      date: DateTime.now().toIso8601String(),
    );
    super.initState();
  }

  void listenDisableButtonSelectItem() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      debugPrint('CALL FUNC EVERY 5 SEC : ${DateTime.now()}');
      if (DateTime.now().minute % 5 == 0 && !isCheck) {
        if (timerChecker.day != DateTime.now().day) {
          setState(() {
            timerChecker = DateTime.now();
            isCheck = true;
          });
          dataSlot = [];
          onResetTable();
          checkEmptyBookingTable();
          onPressedDate(0, true);
          if (isShowModal) {
            setState(() {
              isShowModal = false;
            });
            onCancelModalBooking();
          }
        } else {
          setState(() {
            timerChecker = DateTime.now();
            isCheck = true;
          });
          dataSlot = [];
          onResetTable();
          checkEmptyBookingTable();
          if (isShowModal) {
            setState(() {
              isShowModal = false;
            });
            onCancelModalBooking();
          }
        }
      } else if (isCheck &&
          (DateTime.now().minute > timerChecker.minute ||
              DateTime.now().hour != timerChecker.hour)) {
        setState(() {
          isCheck = false;
        });
      }
    });
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  void initConnectorData() {
    // INDEX DATE FOR TABLE
    dateWordIndex = DateTime.now().weekday;
    // SET BOOKING DATA SELECTED
    bookingSelect = widget.connector!.reserveSlot![dateWordIndex - 1];
    ReserveSlotEntity? bookingNextDay =
        widget.connector!.reserveSlot![dateWordIndex > 6 ? 0 : dateWordIndex];
    bool nextDatyIsOpen = widget.connector
            ?.reserveSlot?[dateWordIndex > 6 ? 0 : dateWordIndex].status ??
        false;
    int hourStart = getTimeNumber(value: bookingSelect!.start, index: 0);
    int hourEnd = getTimeNumber(value: bookingSelect!.end, index: 0);
    int minEnd = getTimeNumber(value: bookingSelect!.end, index: 1);
    int hourNextStart = getTimeNumber(value: bookingNextDay.start, index: 0);
    int minNextStart = getTimeNumber(value: bookingNextDay.start, index: 1);
    // คำนวณแถวของเวลาวันที่เลือก
    rowItem = hourEnd - hourStart + 1 - (minEnd > 0 ? 0 : 1);
    // กรณีวันนี้เปิดถึง 23:59 และ วันพรุ่งนี้เปิด 00:00
    if (hourEnd == 23 &&
        minEnd == 59 &&
        hourNextStart == 0 &&
        minNextStart == 0 &&
        nextDatyIsOpen) {
      rowItem = rowItem + 1;
      isNextDayConnect = true;
    }
  }

  Future<void> onClickAddCard(context) async {
    Navigator.of(context).pop();
    await Navigator.pushNamed(context, RouteNames.payment_kbank);
    onRefreshPage();
  }

  void onPressedDate(int indexSelect, bool isForce) {
    if (indexDate != indexSelect || isForce) {
      DateTime now = DateTime.now();
      DateTime futureDate = now.add(Duration(days: indexSelect));
      ReserveSlotEntity? newBookingSelect =
          widget.connector!.reserveSlot![futureDate.weekday - 1];
      ReserveSlotEntity? bookingNextDay = widget.connector!
          .reserveSlot![futureDate.weekday > 6 ? 0 : futureDate.weekday];
      int hourStart = getTimeNumber(value: newBookingSelect.start, index: 0);
      int hourEnd = getTimeNumber(value: newBookingSelect.end, index: 0);
      int minEnd = getTimeNumber(value: newBookingSelect.end, index: 1);
      int hourNextStart = getTimeNumber(value: bookingNextDay.start, index: 0);
      int minNextStart = getTimeNumber(value: bookingNextDay.start, index: 1);
      int newRowItem = 0;
      bool newIsNextDayConnect = false;
      newRowItem = hourEnd - hourStart + 1 - (minEnd > 0 ? 0 : 1);
      if (hourEnd == 23 &&
          minEnd == 59 &&
          hourNextStart == 0 &&
          minNextStart == 0 &&
          indexSelect < 6) {
        newRowItem = newRowItem + 1;
        newIsNextDayConnect = true;
      }
      setState(() {
        indexDate = indexSelect;
        dateWordIndex = futureDate.weekday;
        bookingSelect = newBookingSelect;
        rowItem = newRowItem;
        startDateSelectedText = DateFormat('dd/MM/yyyy').format(futureDate);
        endDateSelectedText = 'N/A';
        emptyBookingTable = false;
        listReserveOfConnectorData = null;
        isNextDayConnect = newIsNextDayConnect;
      });
      BlocProvider.of<BookingCubit>(context).fetchListReserveFromDate(
        stationId: widget.stationData?.stationId ?? '',
        chargerId: widget.charger?.chargerId ?? '',
        connectorId: widget.connector?.connectorId ?? '',
        connectorQrCode: widget.connector?.connectorQrCode ?? '',
        date: futureDate.toIso8601String(),
      );
      checkEmptyBookingTable();
      if (rowItem > 0) {
        onResetTable();
      }
    }
  }

  void onPressedTime({
    required int row,
    required int index,
  }) {
    debugPrint('ROW/INDEX : ${row}/${index}');
    if (!checkDisableButtonBookingItem(row: row, index: index)) {
      switch (statusSelectTime) {
        case TypeOfButtonSelectTime.selectStart:
          actionTypeOfButtonSelectTimeSelectStart(row: row, index: index);
          break;
        case TypeOfButtonSelectTime.selectEnd:
          actionTypeOfButtonSelectTimeSelectEnd(row: row, index: index);
          break;
        case TypeOfButtonSelectTime.selected:
          actionTypeOfButtonSelectTimeSelected(row: row, index: index);
          break;
        default:
          break;
      }
    }
  }

  void actionTypeOfButtonSelectTimeSelectStart({
    required int row,
    required int index,
  }) {
    if (statusSelectTime == TypeOfButtonSelectTime.selectStart) {
      setState(() {
        rowTimeStart = row;
        indexTimeStart = index;
        rowTimeEnd = null;
        indexTimeEnd = null;
        statusSelectTime = TypeOfButtonSelectTime.selectEnd;
      });
    }
  }

  void actionTypeOfButtonSelectTimeSelectEnd({
    required int row,
    required int index,
  }) {
    int rowTimeStartToCheck = rowTimeStart ?? -1;
    int indexTimeStartToCheck = indexTimeStart ?? -1;
    if (statusSelectTime == TypeOfButtonSelectTime.selectEnd &&
            (row > rowTimeStartToCheck) ||
        (row == rowTimeStartToCheck && index > indexTimeStartToCheck)) {
      // ถ้าปุ่มที่กดเป็นช่องที่อยู่ข้างหน้า TimeStart ให้ Set TimeEnd
      setState(() {
        rowTimeEnd = row;
        indexTimeEnd = index;
        statusSelectTime = TypeOfButtonSelectTime.selected;
        endDateSelectedText = DateFormat('dd/MM/yyyy')
            .format(DateTime.now().add(Duration(days: indexDate)));
        canBook = true;
      });
      setStartTimeAndEndTimeAndTotalTimeSelected();
    } else if (statusSelectTime == TypeOfButtonSelectTime.selectEnd &&
        row == rowTimeStartToCheck &&
        index == indexTimeStartToCheck) {
      // ถ้าปุ่มที่กดเป็นช่องเดียวกับช่องของ TimeStart ให้เคลียร์ค่าทุกอย่างออก
      onResetTable();
    } else if (statusSelectTime == TypeOfButtonSelectTime.selectEnd &&
        (row < rowTimeStartToCheck ||
            (row == rowTimeStartToCheck && index < indexTimeStartToCheck))) {
      // ถ้าปุ่มที่กดเป็นช่องที่อยู่ข้างหลัง TimeStart ให้ Set TimeStart ใหม่เป็นช่องที่กดเข้ามา
      setState(() {
        rowTimeStart = row;
        indexTimeStart = index;
        startTimeSelectedText = '00:00';
        endTimeSelectedText = '00:00';
        totalTimeSelectedText = 0;
        endDateSelectedText = 'N/A';
        statusSelectTime = TypeOfButtonSelectTime.selectEnd;
        canBook = false;
      });
    } else {
      debugPrint('Error');
    }
  }

  void actionTypeOfButtonSelectTimeSelected({
    required int row,
    required int index,
  }) {
    setState(() {
      rowTimeStart = row;
      indexTimeStart = index;
      rowTimeEnd = null;
      indexTimeEnd = null;
      startTimeSelectedText = '00:00';
      endTimeSelectedText = '00:00';
      totalTimeSelectedText = 0;
      statusSelectTime = TypeOfButtonSelectTime.selectEnd;
      endDateSelectedText = 'N/A';
      canBook = false;
    });
  }

  void onResetTable() {
    setState(() {
      rowTimeStart = null;
      indexTimeStart = null;
      rowTimeEnd = null;
      indexTimeEnd = null;
      statusSelectTime = TypeOfButtonSelectTime.selectStart;
      startTimeSelectedText = '00:00';
      endTimeSelectedText = '00:00';
      totalTimeSelectedText = 0;
      startDateSelectedText = DateFormat('dd/MM/yyyy')
          .format(DateTime.now().add(Duration(days: indexDate)));
      endDateSelectedText = 'N/A';
      canBook = false;
    });
  }

  void onPressedPayment() {
    // if (listCardData != null && listCardData!.length > 0) {
    debugPrint('${listCardData}');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (BuildContext context) {
        return ModalSelectPayment(
          idSelectedPayment: idSelectedPayment,
          listPaymentItem: listCardData,
          onPressedAddCard: onClickAddCard,
          onSelectPayment: (int value) {
            setState(() {
              idSelectedPayment = value;
              selectedPayment = listCardData?[value] ??
                  CreditCardEntity(
                    display: '',
                    cardBrand: '',
                    cardExpired: '',
                    cardHashing: '',
                    type: '',
                    name: '',
                    defalut: false,
                  );
              ;
            });
          },
        );
      },
    ).whenComplete(() {});
    // }
  }

  Future<void> onPressedBookNow() async {
    if (canBook) {
      DateTime dateSelectFromIndex =
          DateTime.now().add(Duration(days: indexDate));
      DateTime dateSelectFutureFromIndex =
          dateSelectFromIndex.add(Duration(days: 1));
      int hourStart = getTimeNumber(value: startTimeSelectedText, index: 0);
      int minStart = getTimeNumber(value: startTimeSelectedText, index: 1);
      int hourEnd = getTimeNumber(value: endTimeSelectedText, index: 0);
      int minEnd = getTimeNumber(value: endTimeSelectedText, index: 1);
      if (minEnd == 0) {
        minEnd = 55;
        hourEnd -= 1;
        if (hourEnd == -1) {
          hourEnd = 23;
        }
      } else {
        minEnd -= 5;
      }
      String startTimeReserve =
          '${DateFormat('yyyy-MM-dd HH:mm').format(DateTime(dateSelectFromIndex.year, dateSelectFromIndex.month, dateSelectFromIndex.day, hourStart, minStart))}';
      String endTimeReserve =
          '${DateFormat('yyyy-MM-dd HH:mm').format(DateTime(dateSelectFromIndex.year, dateSelectFromIndex.month, dateSelectFromIndex.day, hourEnd, minEnd))}';
      if (rowTimeStart == rowItem - 1) {
        startTimeReserve =
            '${DateFormat('yyyy-MM-dd HH:mm').format(DateTime(dateSelectFutureFromIndex.year, dateSelectFutureFromIndex.month, dateSelectFutureFromIndex.day, hourStart, minStart))}';
      }
      if (rowTimeEnd == rowItem - 1) {
        endTimeReserve =
            '${DateFormat('yyyy-MM-dd HH:mm').format(DateTime(dateSelectFutureFromIndex.year, dateSelectFutureFromIndex.month, dateSelectFutureFromIndex.day, hourEnd, minEnd))}';
      }
      debugPrint('=======================================================');
      debugPrint('hourStart : ${hourStart}');
      debugPrint('minStart : ${minStart}');
      debugPrint('hourEnd : ${hourEnd}');
      debugPrint('minEnd : ${minEnd}');
      debugPrint('startTimeReserve : ${startTimeReserve}');
      debugPrint('endTimeReserve : ${endTimeReserve}');
      debugPrint('=======================================================');

      if (selectedPayment.cardHashing == '') {
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: translate('alert.description.no_have_payment'),
          textButton: translate('button.close'),
          onPressButton: () {
            Navigator.of(context).pop();
          },
        );
      } else {
        isShowModal = true;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => BookingModalConfirm(
            startTime: startTimeSelectedText,
            endTime: endTimeSelectedText,
            totalTime: '${totalTimeSelectedText} min',
            startDate: startDateSelectedText,
            endDate: endDateSelectedText,
            selectedPayment: selectedPayment,
            onCancelModal: onCancelModalBooking,
            onConfirmModal: () {
              onConfirmModalBooking(startTimeReserve, endTimeReserve);
            },
            stationData: widget.stationData,
            connector: widget.connector,
            priceReserve: widget.connector?.reservePrice ?? 0,
          ),
        );
      }
    }
  }

  void onCancelModalBooking() {
    isShowModal = false;
    Navigator.of(context).pop();
  }

  Future<void> onConfirmModalBooking(
      String startTimeReserve, String endTimeReserve) async {
    isShowModal = false;
    Navigator.of(context).pop();
    BlocProvider.of<BookingCubit>(context).fetchCreateReserve(
        createReserveForm: CreateReserveForm(
      username: jupiterPrefsAndAppData.username ?? '',
      deviceCode: jupiterPrefsAndAppData.deviceId ?? '',
      stationId: widget.stationData?.stationId ?? '',
      chargerId: widget.charger?.chargerId ?? '',
      connectorId: widget.connector?.connectorId ?? '',
      qrCodeConnector:
          '${ConstValue.orgCode}${widget.charger?.chargerId ?? ''}${widget.connector?.connectorId ?? ''}',
      startTimeReserve: startTimeReserve,
      endTimeReserve: endTimeReserve,
      reserveTimeMinute: '${totalTimeSelectedText - 5}',
      payment: PaymentTypeForm(
        type: selectedPayment.type,
        display: (selectedPayment.display)
            .substring(selectedPayment.display.length - 4),
        token: selectedPayment.cardHashing,
        brand: selectedPayment.cardBrand,
        name: selectedPayment.name,
      ),
      orgCode: ConstValue.orgCode,
    ));
  }

  Future<void> onRefreshPage() async {
    DateTime dateSelectFromIndex =
        DateTime.now().add(Duration(days: indexDate));
    onResetTable();
    BlocProvider.of<BookingCubit>(context).fetchListReserveFromDate(
      stationId: widget.stationData?.stationId ?? '',
      chargerId: widget.charger?.chargerId ?? '',
      connectorId: widget.connector?.connectorId ?? '',
      connectorQrCode: widget.connector?.connectorQrCode ?? '',
      date: dateSelectFromIndex.toIso8601String(),
    );
  }

  void setStartTimeAndEndTimeAndTotalTimeSelected() {
    int startAtTime = getTimeNumber(value: bookingSelect!.start, index: 0);
    // CALCULATE START TIME AND END TIME
    String startText = '';
    String endText = '';
    int hourStart = 0;
    int minStart = 0;
    int hourEnd = 0;
    int minEnd = 0;
    hourStart = (rowTimeStart ?? 0) + startAtTime;
    minStart = (indexTimeStart ?? 0) * 5;
    hourEnd = (rowTimeEnd ?? 0) + startAtTime;
    minEnd = ((indexTimeEnd ?? 0) + 1) * 5;
    if (minEnd == 60) {
      hourEnd += 1;
      minEnd = 0;
    }
    // CALCULATE TOTAL TIME
    int totalText = 0;
    DateTime time1 = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hourStart, minStart);
    DateTime time2 = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hourEnd, minEnd);
    totalText = time2.difference(time1).inMinutes;
    totalText = totalText < 0 ? totalText * -1 : totalText;
    if (hourEnd > 23 && hourStart > 23) {
      time2 = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().add(Duration(days: 1)).day, 0, 0);
    }
    if (hourStart < 24) {
      startText =
          '${hourStart > 9 ? hourStart : '0${hourStart}'}:${minStart > 9 ? minStart : '0${minStart}'}';
    } else {
      startText =
          '${hourStart % 24 > 9 ? hourStart % 24 : '0${hourStart % 24}'}:${minStart > 9 ? minStart : '0${minStart}'}';
    }
    if (hourEnd < 24) {
      endText =
          '${hourEnd > 9 ? hourEnd : '0${hourEnd}'}:${minEnd > 9 ? minEnd : '0${minEnd}'}';
    } else {
      endText =
          '${hourEnd % 24 > 9 ? hourEnd % 24 : '0${hourEnd % 24}'}:${minEnd > 9 ? minEnd : '0${minEnd}'}';
    }
    // SET VALUE
    if (totalText <= 60 && !checkIsNotBetweenTimeSlot()) {
      setState(() {
        startTimeSelectedText = startText;
        endTimeSelectedText = endText;
        totalTimeSelectedText = totalText;
      });
      if (hourStart > 23) {
        startDateSelectedText = DateFormat('dd/MM/yyyy')
            .format(DateTime.now().add(Duration(days: indexDate + 1)));
      }
      if (hourEnd > 23) {
        endDateSelectedText = DateFormat('dd/MM/yyyy')
            .format(DateTime.now().add(Duration(days: indexDate + 1)));
      }
    } else if (checkIsNotBetweenTimeSlot()) {
      Utilities.alertOneButtonAction(
        context: context,
        type: AppAlertType.DEFAULT,
        isForce: true,
        title: translate('alert.title.default'),
        description: translate('alert.description.error_reserve_between'),
        textButton: translate('button.try_again'),
        onPressButton: () {
          onResetTable();
          Navigator.of(context).pop();
        },
      );
    } else {
      Utilities.alertOneButtonAction(
        context: context,
        type: AppAlertType.DEFAULT,
        isForce: true,
        title: translate('alert.title.default'),
        description: translate('alert.description.error_reserve_60'),
        textButton: translate('button.try_again'),
        onPressButton: () {
          onResetTable();
          Navigator.of(context).pop();
        },
      );
    }
  }

  bool checkIsNotBetweenTimeSlot() {
    List<List<int>> dataSelect = [];
    int length = ((rowTimeEnd ?? 0) - (rowTimeStart ?? 0)) + 1;
    for (int i = 0; i < length; i++) {
      for (int j = 0; j < 12; j++) {
        if (rowTimeStart == rowTimeEnd &&
            j >= (indexTimeStart ?? 0) &&
            j <= (indexTimeEnd ?? 0)) {
          dataSelect.add([(rowTimeStart ?? 0) + i, j]);
        }
        if (rowTimeStart != rowTimeEnd) {
          if (i == 0 && j >= (indexTimeStart ?? 0)) {
            dataSelect.add([(rowTimeStart ?? 0), j]);
          }
          if (i == 1 && j <= (indexTimeEnd ?? 0)) {
            dataSelect.add([(rowTimeEnd ?? 0), j]);
          }
        }
      }
    }
    for (int i = 0; i < dataSlot.length; i++) {
      List<dynamic> itemList = dataSlot[i];
      for (int j = 0; j < dataSelect.length; j++) {
        List<int> item = itemList[0];
        List<int> selected = dataSelect[j];
        if (item[0] > (rowTimeEnd ?? -1)) {
          return false;
        }
        if (item[0] == selected[0] && item[1] == selected[1] && !itemList[1]) {
          return true;
        }
      }
    }
    return false;
  }

  int getTimeNumber({
    required String value,
    required int index,
  }) {
    try {
      List<String> cut = value.split(':');
      return int.parse(cut[index]);
    } catch (e) {
      return 0;
    }
  }

  String getRowTextHours(int value) {
    if (value < 10) {
      return '0${value}:00';
    } else if (value > 23) {
      int newValue = value % 24;
      return newValue < 10 ? '0${newValue}:00' : '${value % 24}:00';
    } else {
      return '${value}:00';
    }
  }

  Color generateColorBookingItem({
    required int row,
    required int index,
    required bool isBorder,
  }) {
    int? rowTimeStartToCheck = rowTimeStart ?? -1;
    int? indexTimeStartToCheck = indexTimeStart ?? -1;
    int? rowTimeEndToCheck = rowTimeEnd ?? -1;
    int? indexTimeEndToCheck = indexTimeEnd ?? -1;
    // ใส่สีการจอง
    if (checkDisableForReserveSlotFromApiByTimeBetween(
        row: row, index: index)) {
      return disableButton;
      // return AppTheme.red60;
    }
    // ใส่สี StartTime
    if (row == rowTimeStartToCheck && index == indexTimeStartToCheck) {
      return isBorder ? AppTheme.white : reserveButton;
    }
    // ใส่สี EndTime
    if (row == rowTimeEndToCheck &&
        index == indexTimeEndToCheck &&
        statusSelectTime == TypeOfButtonSelectTime.selected) {
      return isBorder ? AppTheme.white : reserveButton;
    }
    // ใส่สีช่องที่อยู่ระหว่าง StartTime กับ EndTime กรณี StartTime กับ EndTime อยู่บรรทัดเดียวกัน
    if (row == rowTimeStartToCheck &&
        row == rowTimeEndToCheck &&
        rowTimeStartToCheck >= 0 &&
        rowTimeEndToCheck >= 0 &&
        index > indexTimeStartToCheck &&
        index < indexTimeEndToCheck &&
        statusSelectTime == TypeOfButtonSelectTime.selected) {
      return isBorder ? AppTheme.white : reserveButton;
    }
    // ใส่สีบรรทัด,ช่องที่อยู่ระหว่าง StartTime กับ EndTime กรณี StartTime กับ EndTime อยู่คนละบรรทัด
    if (
        // บรรทัด StartTime
        (rowTimeStartToCheck != rowTimeEndToCheck &&
                row == rowTimeStartToCheck &&
                index > indexTimeStartToCheck &&
                statusSelectTime == TypeOfButtonSelectTime.selected) ||
            // บรรทัด EndTime
            (rowTimeStartToCheck != rowTimeEndToCheck &&
                row == rowTimeEndToCheck &&
                index < indexTimeEndToCheck &&
                statusSelectTime == TypeOfButtonSelectTime.selected) ||
            // บรรทัดระหว่าง StartTime กับ EndTime
            (rowTimeStartToCheck != rowTimeEndToCheck &&
                row > rowTimeStartToCheck &&
                row < rowTimeEndToCheck &&
                statusSelectTime == TypeOfButtonSelectTime.selected)) {
      return isBorder ? AppTheme.white : reserveButton;
    } // ใส่สีช่องที่เป็นชั่วโมงเดียวกับเวลาปัจจุบัน แต่หน่วยนาทีเลยมาแล้ว
    if (row + getTimeNumber(value: bookingSelect!.start, index: 0) ==
            timerChecker.hour &&
        ((timerChecker.minute + 1) / 5).ceil() > index &&
        indexDate == 0) {
      return disableButton;
    } // ใส่สีช่องทีเวลาเลยมาแล้ว
    if ((row + getTimeNumber(value: bookingSelect!.start, index: 0) <
            timerChecker.hour &&
        indexDate == 0)) {
      return disableButton;
    }
    return AppTheme.white;
  }

  bool checkDisableButtonBookingItem({
    required int row,
    required int index,
  }) {
    if (((row + getTimeNumber(value: bookingSelect!.start, index: 0)) ==
            timerChecker.hour) &&
        (((timerChecker.minute + 1) / 5).ceil() > (index)) &&
        indexDate == 0) {
      return true;
    } else if ((row + getTimeNumber(value: bookingSelect!.start, index: 0) <
            timerChecker.hour &&
        indexDate == 0)) {
      return true;
    } else if (checkDisableForReserveSlotFromApiByTimeBetween(
        row: row, index: index)) {
      return true;
    }
    return false;
  }

  bool checkDisableForReserveSlotFromApiByTimeBetween({
    required int row,
    required int index,
  }) {
    // debugPrint('checkTime : ${checkTime}');
    // debugPrint('startTimeOfDay : ${startTimeOfDay}');
    // debugPrint('endTimeOfDay : ${endTimeOfDay}');
    // FALSE = ไม่ปิดช่อง | TRUE = ปิดช่อง
    int lengthSlot = listReserveOfConnectorData?.length ?? 0;
    // เวลาของช่องนี้
    int hourCheck = row + getTimeNumber(value: bookingSelect!.start, index: 0);
    int minCheck = (index * 5) + 5;
    if (minCheck == 60) {
      hourCheck += 1;
      minCheck = 0;
    }
    // เวลาปัจจุบัน
    DateTime now = DateTime.now();
    // ถ้าชั่วโมงปัจจุบันมากกว่าชั่วโมงของช่องนี้ (เฉพาะวันนี้)
    if (now.hour > (hourCheck == 0 ? 24 : hourCheck) && indexDate == 0) {
      return false;
    }
    if (lengthSlot > 0) {
      for (int i = 0; i < lengthSlot; i++) {
        // ช่วงเวลาของ Slot ที่ i
        DateTime startSlot =
            DateTime.parse(listReserveOfConnectorData![i].startTimeReserve)
                .toLocal();
        DateTime endSlot =
            DateTime.parse(listReserveOfConnectorData![i].endTimeReserve)
                .toLocal();
        DateTime thisSelectDate = DateTime.now().add(Duration(days: indexDate));
        DateTime futureDate = thisSelectDate.add(Duration(days: 1));
        DateTime pastDate = thisSelectDate.subtract(Duration(days: 1));
        if (row == 0) {
          // แถวแรกวันเริ่มในวันนี้
          if (startSlot.hour == endSlot.hour &&
              (startSlot.day == thisSelectDate.day ||
                  endSlot.day == thisSelectDate.day)) {
            if (hourCheck == startSlot.hour &&
                hourCheck == endSlot.hour &&
                minCheck > startSlot.minute &&
                minCheck <= endSlot.minute) {
              return true;
            }
          }
          // แถวแรกวันเริ่มเมื่อวาน
          if (startSlot.hour != endSlot.hour &&
              (startSlot.day == pastDate.day ||
                  endSlot.day == thisSelectDate.day)) {
            if (hourCheck == endSlot.hour && minCheck <= endSlot.minute) {
              return true;
            }
            if (hourCheck < endSlot.hour &&
                minCheck > startSlot.minute &&
                hourCheck == 0) {
              return true;
            }
          }
          if (row == 0 &&
              hourCheck > 0 &&
              startSlot.day == thisSelectDate.day &&
              endSlot.day == thisSelectDate.day) {
            if (startSlot.hour == endSlot.hour) {
              if (hourCheck == startSlot.hour &&
                  hourCheck == endSlot.hour &&
                  minCheck > startSlot.minute &&
                  minCheck <= endSlot.minute) {
                return true;
              }
            }
            if (startSlot.hour != endSlot.hour &&
                startSlot.day == thisSelectDate.day) {
              if (hourCheck == startSlot.hour && minCheck > startSlot.minute) {
                return true;
              }
              if (hourCheck == endSlot.hour && minCheck <= endSlot.minute) {
                return true;
              }
            }
          }
        } else if (row > (rowItem - 2)) {
          if (startSlot.day == thisSelectDate.day &&
              endSlot.day == futureDate.day) {
            if (hourCheck == 24 && minCheck <= endSlot.minute) {
              return true;
            }
          }
          if (startSlot.day == futureDate.day &&
              endSlot.day == futureDate.day) {
            if (hourCheck % 24 == startSlot.hour &&
                hourCheck % 24 == endSlot.hour &&
                minCheck > startSlot.minute &&
                minCheck <= endSlot.minute) {
              return true;
            }
            if (hourCheck % 24 == startSlot.hour &&
                    hourCheck % 24 < endSlot.hour &&
                    (minCheck > startSlot.minute) ||
                (minCheck == 0 && hourCheck % 24 == endSlot.hour)) {
              return true;
            }
          }
        } else {
          // ถ้าเวลาจองอยู่ในชั่วโมงเดียวกัน
          if (startSlot.hour == endSlot.hour &&
              startSlot.day == thisSelectDate.day) {
            if (hourCheck == startSlot.hour &&
                hourCheck == endSlot.hour &&
                minCheck > startSlot.minute &&
                minCheck <= endSlot.minute) {
              return true;
            }
          }
          // ถ้าเวลาจองชั่วโมงเริ่มต้นน้อยกว่าชั่วโมงสิ้นสุดเดียวกัน
          if (startSlot.hour != endSlot.hour &&
              startSlot.day == thisSelectDate.day) {
            // ข่องสุดท้ายของวัน
            if (hourCheck == 24 &&
                (row == rowItem - 2) &&
                index == 11 &&
                startSlot.day == thisSelectDate.day &&
                endSlot.day == futureDate.day) {
              return true;
            }
            if (hourCheck == startSlot.hour && minCheck > startSlot.minute) {
              return true;
            }
            if (hourCheck == endSlot.hour && minCheck <= endSlot.minute) {
              return true;
            }
          }
        }
      }
    }
    return false;
  }

  String generateTextStartAndEnd({
    required int row,
    required int index,
  }) {
    if (row == rowTimeStart && index == indexTimeStart) {
      return '●';
    }
    if (row == rowTimeEnd && index == indexTimeEnd) {
      return '🕛';
    }
    return '';
  }

  Radius getRadiusIsStartOrEndTime({
    required int row,
    required int index,
    required String position,
  }) {
    if (position == 'START' && row == rowTimeStart && index == indexTimeStart) {
      return Radius.circular(200);
    }
    if (position == 'END' && row == rowTimeEnd && index == indexTimeEnd) {
      return Radius.circular(200);
    }
    return Radius.circular(0);
  }

  bool checkRenderRowFollowTimeNow({required int row}) {
    bool checkRender = false;
    if (indexDate == 0) {
      int hourCheck = getTimeNumber(value: bookingSelect!.start, index: 0);
      checkRender = ((row + hourCheck) > timerChecker.hour) ||
          ((row + hourCheck) == timerChecker.hour && timerChecker.minute < 55);
    } else {
      checkRender = true;
    }
    return checkRender;
  }

  void checkEmptyBookingTable() {
    int hourEnd = getTimeNumber(value: bookingSelect!.end, index: 0);
    int minEnd = getTimeNumber(value: bookingSelect!.end, index: 1) == 0
        ? 60
        : getTimeNumber(value: bookingSelect!.end, index: 1);
    if ((timerChecker.hour + 1 == hourEnd &&
            timerChecker.minute + 5 >= minEnd &&
            indexDate == 0) ||
        (timerChecker.hour == hourEnd && indexDate == 0)) {
      setState(() {
        emptyBookingTable = true;
      });
    }
  }

  void setFirstCardFromDefaultCard() {
    int listCardDataLength = listCardData?.length ?? 0;
    if (listCardData != null && listCardDataLength > 0) {
      for (int i = 0; i < listCardDataLength; i++) {
        if (listCardData![i].defalut == true) {
          setState(() {
            selectedPayment = listCardData?[i] ??
                CreditCardEntity(
                  display: '',
                  cardBrand: '',
                  cardExpired: '',
                  cardHashing: '',
                  type: '',
                  name: '',
                  defalut: false,
                );
            ;
            idSelectedPayment = i;
          });
          break;
        }
      }
    }
  }

  void actionBookingListLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionBookingListFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
          errorPage = true;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: state.message ?? translate('alert.description.default'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            setState(() {
              errorPage = false;
            });
            BlocProvider.of<BookingCubit>(context).resetInitialBookingState();
            BlocProvider.of<BookingCubit>(context).fetchListReserveFromDate(
              stationId: widget.stationData?.stationId ?? '',
              chargerId: widget.charger?.chargerId ?? '',
              connectorId: widget.connector?.connectorId ?? '',
              connectorQrCode: widget.connector?.connectorQrCode ?? '',
              date: DateTime.now().toIso8601String(),
            );
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  void actionBookingListSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
          listReserveOfConnectorData = state.listReserveData.slot ?? [];
        });
        checkDisableForReserveSlotFromApiByTimeBetween(row: 0, index: 0);
        BlocProvider.of<BookingCubit>(context).fetchLoadCreditCardList();
      }
    });
  }

  void actionBookingGetPaymentLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPayment) {
        setState(() {
          loadingPayment = true;
        });
      }
    });
  }

  void actionBookingGetPaymentFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPayment) {
        setState(() {
          loadingPayment = false;
        });
        BlocProvider.of<BookingCubit>(context).resetInitialBookingState();
      }
    });
  }

  void actionBookingGetPaymentSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPayment) {
        setState(() {
          loadingPayment = false;
          listCardData = state.creditCardList ?? [];
        });
        setFirstCardFromDefaultCard();
        BlocProvider.of<BookingCubit>(context).resetInitialBookingState();
      }
    });
  }

  void actionBookingCreateReserveLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionBookingCreateReserveSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BookingReceiptPage(
            reserveReceiptData: state.reserveReceiptData,
          );
        }));
      }
    });
  }

  void actionBookingCreateReserveFailure(state) {
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
            BlocProvider.of<BookingCubit>(context).resetInitialBookingState();
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  Widget renderBookingPage() {
    if (!errorPage) {
      return Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: sizePaddingHorizontal),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: ListView(
                physics: ClampingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  BookingStationName(
                    stationData: widget.stationData,
                    connector: widget.connector,
                  ),
                  BookingSelectDetail(
                    startTime: startTimeSelectedText,
                    endTime: endTimeSelectedText,
                    totalTime: '${totalTimeSelectedText} min',
                    startDate: startDateSelectedText,
                    endDate: endDateSelectedText,
                  ),
                  BookingSelectDate(
                    index: indexDate,
                    onPressedDate: onPressedDate,
                    dateToRender: timerChecker,
                  ),
                  renderBookingTable(),
                ],
              ),
            ),
          ),
          BookingButtonButtom(
            bookingSelect: bookingSelect,
            emptyBookingTable: emptyBookingTable,
            errorPage: errorPage,
            selectedPayment: selectedPayment,
            canBook: canBook,
            onPressedBookNow: onPressedBookNow,
            onPressedPayment: onPressedPayment,
            priceReserve: widget.connector?.reservePrice ?? 0,
          ),
        ],
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAsset.img_default_empty,
              width: 100,
              height: 100,
            ),
            TextLabel(
              text: translate('alert.title.default'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.large),
              color: AppTheme.black40,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
    }
  }

  Widget renderBookingTable() {
    if (bookingSelect != null &&
        bookingSelect!.status == true &&
        !emptyBookingTable) {
      return Container(
        padding: EdgeInsets.only(bottom: sizePaddingHorizontal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            renderTextHeader(),
            renderMinuteHeader(),
            renderListButtonItemBooking(),
            // renderTextUnderTable(),
            SizedBox(height: heightButtonBottom),
          ],
        ),
      );
    } else {
      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAsset.img_default_empty,
              width: 100,
              height: 100,
            ),
            TextLabel(
              text: bookingSelect != null &&
                      bookingSelect!.status == true &&
                      emptyBookingTable
                  ? translate('empty.booking_time_out')
                  : translate('empty.not_open_booking'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.large),
              color: AppTheme.black40,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      );
    }
  }

  Widget renderTextHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextLabel(
          text: translate('booking_page.booking_time'),
          fontSize:
              Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
          fontWeight: FontWeight.bold,
          color: AppTheme.blueDark,
        ),
        Material(
          color: AppTheme.white,
          child: InkWell(
            onTap: onResetTable,
            borderRadius: BorderRadius.circular(12),
            splashColor: AppTheme.borderGray,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: TextLabel(
                text: translate('booking_page.reset'),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.little),
                color: AppTheme.gray9CA3AF,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget renderMinuteHeader() {
    List<Widget> listMinuteHeader = [];
    for (int i = 0; i < itemColumn - 1; i++) {
      listMinuteHeader.add(
        Row(
          children: [
            Container(
              width: ((MediaQuery.of(context).size.width) -
                      sizeStartTable -
                      (sizePaddingHorizontal * 2)) /
                  itemColumn,
              height: 30,
              alignment: Alignment.centerRight,
              child: TextLabel(
                text: i == itemColumn - 1 ? '' : '${(i + 1) * 5}',
                color: AppTheme.blueDark,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.little),
              ),
            ),
          ],
        ),
      );
    }
    return Row(
      children: [
        Container(
          width: sizeStartTable +
              (((MediaQuery.of(context).size.width) -
                          sizeStartTable -
                          (sizePaddingHorizontal * 2)) /
                      itemColumn) *
                  0.2,
          height: 30,
        ),
        Row(
          children: listMinuteHeader,
        ),
      ],
    );
  }

  Widget renderListButtonItemBooking() {
    dataSlot = [];
    List<Widget> listButtonItemBooking = [];
    // debugPrint('===========================================');
    // debugPrint('duration : ${bookingSelect!.duration}');
    // debugPrint('start : ${bookingSelect!.start}');
    // debugPrint('end : ${bookingSelect!.end}');
    // debugPrint('===========================================');
    for (int i = 0; i < rowItem; i++) {
      listButtonItemBooking.add(
        renderButtonItemBooking(
          rowItem: rowItem,
          rowIndex: i,
          isLastRow: i == rowItem - 1,
        ),
      );
    }
    return Column(
      children: listButtonItemBooking,
    );
  }

  Widget renderButtonItemBooking({
    required int rowItem,
    required int rowIndex,
    required bool isLastRow,
  }) {
    List<Widget> listButtonItem = [];
    bool checkRender = checkRenderRowFollowTimeNow(row: rowIndex);
    for (int i = 0; i < itemColumn; i++) {
      if (checkRender) {
        dataSlot.add([
          [rowIndex, i],
          !checkDisableButtonBookingItem(row: rowIndex, index: i)
        ]);
        listButtonItem.add(
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                width: ((MediaQuery.of(context).size.width) -
                        sizeStartTable -
                        (sizePaddingHorizontal * 2)) /
                    itemColumn,
                height: 40,
                decoration: BoxDecoration(
                  color: generateColorBookingItem(
                      row: rowIndex, index: i, isBorder: true),
                  border: Border(
                    top: BorderSide(width: 1.0, color: AppTheme.borderGray),
                    left: BorderSide(width: 1.0, color: AppTheme.borderGray),
                    bottom: BorderSide(
                        width: isLastRow ? 1 : 0, color: AppTheme.borderGray),
                    right: BorderSide(
                        width: i == itemColumn - 1 ? 1 : 0,
                        color: AppTheme.borderGray),
                  ),
                ),
                child: Material(
                  color: AppTheme.white,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    splashColor: AppTheme.borderGray,
                    onTap: () {
                      onPressedTime(row: rowIndex, index: i);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: generateColorBookingItem(
                            row: rowIndex, index: i, isBorder: false),
                        borderRadius: BorderRadius.only(
                          topLeft: getRadiusIsStartOrEndTime(
                              row: rowIndex, index: i, position: 'START'),
                          bottomLeft: getRadiusIsStartOrEndTime(
                              row: rowIndex, index: i, position: 'START'),
                          topRight: getRadiusIsStartOrEndTime(
                              row: rowIndex, index: i, position: 'END'),
                          bottomRight: getRadiusIsStartOrEndTime(
                              row: rowIndex, index: i, position: 'END'),
                        ),
                      ),
                      child: TextLabel(
                        text: generateTextStartAndEnd(row: rowIndex, index: i),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.small),
                        color: AppTheme.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
    return Row(
      children: [
        checkRender
            ? Container(
                padding: const EdgeInsets.only(right: 8),
                alignment: Alignment.centerRight,
                width: sizeStartTable,
                height: 40,
                child: TextLabel(
                  text: getRowTextHours(
                      getTimeNumber(value: bookingSelect!.start, index: 0) +
                          rowIndex),
                  color: AppTheme.blueDark,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                ),
              )
            : SizedBox(),
        Row(
          children: listButtonItem,
        ),
      ],
    );
  }

  Widget renderTextUnderTable() {
    return Container(
      padding: EdgeInsets.only(top: sizePaddingHorizontal),
      child: Center(
        child: TextLabel(
          text: '${description}',
          color: AppTheme.gray9CA3AF,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefreshPage,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppTheme.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppTheme.white,
              iconTheme: const IconThemeData(
                color: AppTheme.blueDark, //change your color here
              ),
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
                  onPressed: onPressedBackButton),
              centerTitle: true,
              title: TextLabel(
                text: translate('app_title.booking'),
                color: AppTheme.blueDark,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.title),
                fontWeight: FontWeight.bold,
              ),
            ),
            body: BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
              switch (state.runtimeType) {
                case BookingListLoading:
                  actionBookingListLoading();
                  break;
                case BookingListSuccess:
                  actionBookingListSuccess(state);
                  break;
                case BookingListFailure:
                  actionBookingListFailure(state);
                  break;
                case BookingGetPaymentLoading:
                  actionBookingGetPaymentLoading();
                  break;
                case BookingGetPaymentSuccess:
                  actionBookingGetPaymentSuccess(state);
                  break;
                case BookingGetPaymentFailure:
                  actionBookingGetPaymentFailure(state);
                  break;
                case BookingCreateReserveLoading:
                  actionBookingCreateReserveLoading();
                  break;
                case BookingCreateReserveSuccess:
                  actionBookingCreateReserveSuccess(state);
                  break;
                case BookingCreateReserveFailure:
                  actionBookingCreateReserveFailure(state);
                  break;
              }
              return renderBookingPage();
            }),
          ),
          LoadingPage(visible: loadingPage),
        ],
      ),
    );
  }
}
