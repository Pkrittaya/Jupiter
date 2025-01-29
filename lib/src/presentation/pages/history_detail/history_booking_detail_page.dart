import 'dart:io';
import 'dart:typed_data';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/history_detail/widgets/button_save_image.dart';
import 'package:jupiter_api/domain/entities/history_booking_detail_entity.dart';
import 'package:jupiter/src/presentation/pages/history_detail/cubit/history_detail_cubit.dart';
import 'package:jupiter/src/presentation/pages/history_detail/widgets/bg_image.dart';
import 'package:jupiter/src/presentation/pages/history_detail/widgets/col_text_with_image.dart';
import 'package:jupiter/src/presentation/widgets/dash_line.dart';
import 'package:jupiter/src/presentation/pages/history_detail/widgets/receipt_border.dart';
import 'package:jupiter/src/presentation/pages/history_detail/widgets/row_payment_method.dart';
import 'package:jupiter/src/presentation/pages/history_detail/widgets/row_total_price.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/presentation/widgets/row_with_two_text.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import '../../../firebase_log.dart';

class HistoryBookingDetailPage extends StatefulWidget {
  const HistoryBookingDetailPage({Key? key, required this.reserveOn})
      : super(key: key);
  final int reserveOn;
  @override
  _HistoryBookingDetailPageState createState() =>
      _HistoryBookingDetailPageState();
}

class _HistoryBookingDetailPageState extends State<HistoryBookingDetailPage> {
  HistoryBookingDetailEntity? data;
  bool hasBgImage = false;
  bool isLoadingPage = false;

  // SAVE IMAGE
  bool isSaveImage = false;
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
    BlocProvider.of<HistoryDetailCubit>(context)
        .fetchLoadHistoryBookingDetail(reserveOn: widget.reserveOn);
  }

  String getDateTimeFormat(String? time) {
    try {
      DateTime dateTime = DateTime.parse(time!).toLocal();
      return DateFormat('dd MMM yyyy, HH:mm:ss').format(dateTime) + ' hr';
    } catch (e) {
      return 'N/A';
    }
  }

  String getBookingTime() {
    try {
      int min = int.parse(data?.reserveTimeMinute ?? '');
      if (min < 60) {
        return '00:${min} hr';
      } else {
        double minMore = min / 60;
        int minMoreBack = min % 60;
        return '${minMore.floor() > 9 ? minMore.floor().toStringAsFixed(0) : '0${minMore.toStringAsFixed(0)}'}:${minMoreBack > 9 ? minMoreBack.toStringAsFixed(0) : '0${minMoreBack.toStringAsFixed(0)}'} hr';
      }
    } catch (e) {
      return '00:00 hr';
    }
  }

  Future<bool> requestPermissionPhoto() async {
    bool canSaveImageNew = false;
    bool status = false;
    try {
      if (Platform.isAndroid) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          status = await Permission.photos.isGranted;
        } else {
          status = await Permission.storage.isGranted;
        }
      } else {
        // iOS
        bool statusiOS_1 = await Permission.photos.isGranted;
        bool statusiOS_2 = await Permission.photos.isLimited;
        status = statusiOS_1 || statusiOS_2;
      }
      if (!status) {
        PermissionStatus newStatus;
        if (Platform.isAndroid) {
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          if (androidInfo.version.sdkInt >= 33) {
            newStatus = await Permission.photos.request();
          } else {
            newStatus = await Permission.storage.request();
          }
        } else {
          // iOS
          newStatus = await Permission.photos.request();
        }
        if (newStatus.isGranted) {
          canSaveImageNew = true;
        } else {
          canSaveImageNew = false;
        }
      } else {
        canSaveImageNew = true;
      }
      return canSaveImageNew;
    } catch (e) {
      return canSaveImageNew;
    }
  }

  String generateFileName(int length) {
    return 'jupiter_${DateTime.now().millisecondsSinceEpoch}';
  }

  void onSaveImage() async {
    if (!isSaveImage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isSaveImage = true;
        });
      });
      bool getPermssionIsGranted = await requestPermissionPhoto();
      if (getPermssionIsGranted) {
        final bytes = await controller.capture();
        Directory? tempDir = await getApplicationDocumentsDirectory();
        File file =
            await File('${tempDir.path}/${generateFileName}.png').create();
        file.writeAsBytesSync(bytes!);
        debugPrint("Path ${file.absolute}");
        final result =
            await ImageGallerySaver.saveImage(bytes.buffer.asUint8List());
        debugPrint(" ImageResult ${result.toString()}");
        try {
          if (mounted) {
            Utilities.alertAfterSaveAction(
              context: context,
              type: AppAlertType.SUCCESS,
              text: translate('receipt_page.save_image'),
            );
          }
        } catch (e) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              isSaveImage = false;
            });
          });
        }
      } else {
        try {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              isSaveImage = false;
            });
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Utilities.alertOneButtonAction(
              context: context,
              type: AppAlertType.DEFAULT,
              isForce: false,
              title: translate('alert_permission_photos.request_permission'),
              description: translate(
                  'alert_permission_photos.request_permission_description'),
              textButton: translate('button.setting'),
              onPressButton: () {
                Navigator.of(context).pop();
                onPressedGoToSetting();
              },
            );
          });
        } catch (e) {}
      }
    }
  }

  Future<void> onPressedGoToSetting() async {
    try {
      await AppSettings.openAppSettings(
        type: AppSettingsType.settings,
        asAnotherTask: true,
      );
    } catch (e) {
      debugPrint('ERROR TO OPEN APP SETTING');
    }
  }

  void actionHistoryBookingLoadingStart() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isLoadingPage) {
        setState(() {
          isLoadingPage = true;
        });
      }
    });
  }

  void actionHistoryBookingDetailLoadingSuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingPage) {
        setState(() {
          data = state.historyBookingDetail;
          isLoadingPage = false;
        });
      }
    });
  }

  void actionHistoryBookingDetailLoadingFailure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoadingPage) {
        setState(() {
          isSaveImage = true;
          isLoadingPage = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.blueLight,
      appBar: AppBar(
        backgroundColor: AppTheme.blueLight,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: BlocBuilder<HistoryDetailCubit, HistoryDetailState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case HistoryBookingDetailLoadingStart:
                actionHistoryBookingLoadingStart();
                break;
              case HistoryBookingDetailLoadingSuccess:
                actionHistoryBookingDetailLoadingSuccess(state);
                break;
              case HistoryBookingDetailLoadingFailure:
                actionHistoryBookingDetailLoadingFailure();
                break;
            }
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppTheme.blueLight,
                ),
                padding: const EdgeInsets.all(6),
                child: renderReceiptCardDetail(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget renderReceiptCardDetail() {
    return Skeletonizer(
      enabled: isLoadingPage,
      child: Column(
        children: [
          WidgetsToImage(
            controller: controller,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    minHeight: 200,
                  ),
                  decoration: const ShapeDecoration(
                    shape: ReceiptBorder(
                      pathWidth: 1,
                      radius: 10,
                      borderColor: AppTheme.borderGray,
                      rightBotReverse: true,
                      leftBotReverse: true,
                      bottomDash: true,
                      bottomBorderColor: AppTheme.blueD,
                    ),
                    color: AppTheme.white,
                  ),
                  child: Stack(
                    children: [
                      //* Background Image
                      BGImage(hasBgImage: hasBgImage),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowTotalPrice(
                              hasBgImage: hasBgImage,
                              total: data?.reservePrice != null
                                  ? '${Utilities.formatMoney('${data?.reservePrice}', 2)} THB'
                                  : '0.00 THB',
                              isBooking: true,
                            ),
                            const SizedBox(height: 16),
                            //* Dash in Container
                            !hasBgImage
                                ? DashLine(width: 0.9, color: AppTheme.blueD)
                                : const SizedBox(),
                            const SizedBox(height: 20),
                            TextLabel(
                              color: AppTheme.black,
                              text: data?.stationName ?? 'N/A',
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.normal,
                              ),
                              fontWeight: FontWeight.w700,
                            ),
                            TextLabel(
                              color: AppTheme.black,
                              text: data?.chargeName ?? 'N/A',
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.little,
                              ),
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(height: 12),
                            RowWithTwoText(
                              textLeft: translate('receipt_page.start_time'),
                              textRight: data?.startTimeReserve != null
                                  ? getDateTimeFormat(
                                      data?.startTimeReserve.toString())
                                  : 'N/A',
                              textLeftFontColor: AppTheme.black40,
                              textRightFontColor: AppTheme.black,
                              textRightFontWeight: FontWeight.w400,
                              textLeftSize:
                                  Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.normal,
                              ),
                              textRightSize:
                                  Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.normal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            RowWithTwoText(
                              textLeft: translate('receipt_page.end_time'),
                              textRight: data?.endTimeReserve != null
                                  ? getDateTimeFormat(
                                      data?.endTimeReserve.toString())
                                  : 'N/A',
                              textLeftFontColor: AppTheme.black40,
                              textRightFontColor: AppTheme.black,
                              textRightFontWeight: FontWeight.w400,
                              textLeftSize:
                                  Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.normal,
                              ),
                              textRightSize:
                                  Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.normal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            RowWithTwoText(
                              textLeft: translate('booking_page.booking_rate'),
                              textRight: data?.reserveRate != null
                                  ? '${Utilities.formatMoney('${data?.reserveRate}', 2)} THB/hr'
                                  : 'N/A',
                              textLeftFontColor: AppTheme.black40,
                              textRightFontColor: AppTheme.black,
                              textRightFontWeight: FontWeight.w400,
                              textLeftSize:
                                  Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.normal,
                              ),
                              textRightSize:
                                  Utilities.sizeFontWithDesityForDisplay(
                                      context, AppFontSize.normal),
                            ),
                            const SizedBox(height: 8),
                            RowWithTwoText(
                              flexLeft: 1,
                              flexRight: 1,
                              textLeft: translate('booking_page.booking_time'),
                              textRight: data?.reserveTimeMinute != null
                                  ? getBookingTime()
                                  : 'N/A',
                              textLeftFontColor: AppTheme.black40,
                              textRightFontColor: AppTheme.black,
                              textRightFontWeight: FontWeight.w700,
                              textLeftSize:
                                  Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.normal,
                              ),
                              textRightSize:
                                  Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.normal,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Container(
                                height: 1,
                                color: AppTheme.black20,
                              ),
                            ),
                            const SizedBox(height: 12),
                            RowWithTwoText(
                              textLeft: translate('booking_page.booking_fee'),
                              textRight: data?.reserveBeforeTax != null &&
                                      data?.reserveBeforeTax != ''
                                  ? '${Utilities.formatMoney('${data?.reserveBeforeTax}', 2)} THB'
                                  : '0.00 THB',
                              textLeftFontColor: AppTheme.black40,
                              textRightFontColor: AppTheme.black,
                              textRightFontWeight: FontWeight.w400,
                              textLeftSize:
                                  Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.normal,
                              ),
                              textRightSize:
                                  Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.normal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            RowWithTwoText(
                              textLeft: translate('receipt_page.vat'),
                              textRight: data?.reserveTax != null &&
                                      data?.reserveTax != ''
                                  ? '${Utilities.formatMoney('${data?.reserveTax}', 2)} THB'
                                  : '0.00 THB',
                              textLeftFontColor: AppTheme.black40,
                              textRightFontColor: AppTheme.black,
                              textRightFontWeight: FontWeight.w400,
                              textLeftSize:
                                  Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.normal,
                              ),
                              textRightSize:
                                  Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.normal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            RowWithTwoText(
                              textLeft: translate('receipt_page.total'),
                              textRight: data?.reservePrice != null &&
                                      data?.reservePrice != ''
                                  ? '${Utilities.formatMoney('${data?.reservePrice}', 2)} THB'
                                  : '0.00 THB',
                              textLeftFontColor: AppTheme.black40,
                              textRightFontColor: AppTheme.blueDark,
                              textRightFontWeight: FontWeight.w700,
                              textLeftSize:
                                  Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.normal,
                              ),
                              textRightSize:
                                  Utilities.sizeFontWithDesityForDisplay(
                                context,
                                AppFontSize.large,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Container(
                                height: 1,
                                color: AppTheme.black20,
                              ),
                            ),
                            const SizedBox(height: 12),
                            RowPaymentMethod(
                              loading: isLoadingPage,
                              value: data?.paymentMethod ?? '',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    shape: ReceiptBorder(
                      pathWidth: 1,
                      radius: 10,
                      borderColor: AppTheme.borderGray,
                      leftTopReverse: true,
                      rightTopReverse: true,
                      topVisible: false,
                      bottomBorderColor: AppTheme.borderGray,
                    ),
                    color: AppTheme.white,
                  ),
                  child: ColTextWithImage(loading: isLoadingPage),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ButtonSaveImage(
            isLoading: isLoadingPage,
            disable: isSaveImage,
            onClickButton: onSaveImage,
          ),
        ],
      ),
    );
  }
}
