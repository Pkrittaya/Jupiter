import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/scan_qrcode/widgets/qrcode_appbar.dart';
import 'package:jupiter/src/presentation/widgets/button.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter_api/domain/entities/search_coupon_for_used_entity.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/cubit/cubit/check_in_cubit.dart';
import 'package:jupiter/src/presentation/pages/coupon_detail/coupon_detail_page.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// ignore: must_be_immutable
class QRCodeCoupon extends StatefulWidget {
  QRCodeCoupon(
      {Key? key,
      this.listItemOffer,
      this.onSelectCouponOffer,
      this.selectCoupon = ''})
      : super(key: key);

  final List<SearchCouponItemForUsedEntity>? listItemOffer;
  final Function(String, bool)? onSelectCouponOffer;
  String selectCoupon;

  @override
  State<QRCodeCoupon> createState() => _QRCodeCouponState();
}

class _QRCodeCouponState extends State<QRCodeCoupon> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QRCODE');
  QRViewController? controller;
  Barcode? result;
  DateTime? lastScan;
  double heightAppbar = AppBar().preferredSize.height;
  List<SearchCouponItemForUsedEntity>? listCouponForUsed =
      List.empty(growable: true);
  // SHOW SETTING PAGE
  bool showSettingPage = false;
  bool loadingPage = true;
  bool isSearchCoupon = false;

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

  void requestPermission() async {
    try {
      bool status = await Permission.camera.isGranted;
      if (!status) {
        PermissionStatus newStatus = await Permission.camera.request();
        if (newStatus.isGranted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              loadingPage = false;
              showSettingPage = false;
            });
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              loadingPage = false;
              showSettingPage = true;
            });
          });
        }
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            loadingPage = false;
            showSettingPage = false;
          });
        });
      }
    } catch (e) {}
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      final currentScan = DateTime.now();
      if (lastScan == null ||
          currentScan.difference(lastScan!) > const Duration(seconds: 3)) {
        lastScan = currentScan;

        BlocProvider.of<CheckInCubit>(context)
            .loadScanQrcodeCoupon(couponCode: result!.code ?? '');
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            translate('alert.description.dont_have_permission_camera'),
          ),
        ),
      );
    }
  }

  void actionScanQrcodeCouponLoading() {}
  void actionScanQrcodeCouponSuccess(
      SearchCouponItemForUsedEntity? couponEntity) {
    /** ตรวจสอบ code ว่ามีจริงหรือไม่ **/
    if (couponEntity != null) {
      if (couponEntity.statusUsedCoupon == false) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return CouponDetailPage(
            couponID: couponEntity.couponCode,
            bottomBar: 'checkin',
            onSelectCouponOffer: widget.onSelectCouponOffer,
            selectCoupon: widget.selectCoupon,
          );
        }));
      } else {
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate("check_in_page.modal_offers.title_alert"),
          description:
              translate("check_in_page.modal_offers.description_alert"),
          textButton: translate('button.try_again'),
          onPressButton: () {
            isSearchCoupon = true;
            Navigator.of(context).pop();
          },
        );
        Future.delayed(const Duration(seconds: 3), () {
          debugPrint('isSearchCoupon : $isSearchCoupon');
          if (!isSearchCoupon) {
            Navigator.of(context).pop();
          } else {
            isSearchCoupon = false;
          }
        });
      }
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(translate('coupon.coupon_list.not_find'))),
      // );
      Utilities.alertOneButtonAction(
        context: context,
        type: AppAlertType.DEFAULT,
        isForce: true,
        title: translate('alert.title.default'),
        description: translate('coupon.coupon_list.not_find'),
        textButton: translate('button.try_again'),
        onPressButton: () {
          isSearchCoupon = true;
          Navigator.of(context).pop();
        },
      );
      Future.delayed(const Duration(seconds: 3), () {
        debugPrint('isSearchCoupon : $isSearchCoupon');
        if (!isSearchCoupon) {
          Navigator.of(context).pop();
        } else {
          isSearchCoupon = false;
        }
      });
    }
    try {
      BlocProvider.of<CheckInCubit>(context).loadCouponSearch();
    } catch (e) {}
  }

  void actionScanQrcodeCouponFailure() {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text(translate('coupon.coupon_list.not_find'))),
    // );
    Utilities.alertOneButtonAction(
      context: context,
      type: AppAlertType.DEFAULT,
      isForce: true,
      title: translate('alert.title.default'),
      description: translate('coupon.coupon_list.not_find'),
      textButton: translate('button.try_again'),
      onPressButton: () {
        isSearchCoupon = true;
        Navigator.of(context).pop();
      },
    );
    Future.delayed(const Duration(seconds: 3), () {
      debugPrint('isSearchCoupon : $isSearchCoupon');
      if (!isSearchCoupon) {
        Navigator.of(context).pop();
      } else {
        isSearchCoupon = false;
      }
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    try {
      if (Platform.isAndroid) {
        controller!.pauseCamera();
      }
      controller!.resumeCamera();
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool value) {
        debugPrint('PopScope : ${value}');
        if (!value) {
          onPressedBackButton();
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.transparent,
        body: loadingPage
            ? Stack(
                children: [
                  Container(
                    color: AppTheme.white,
                    height: height,
                    width: width,
                    child: Center(
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          color: AppTheme.lightBlue,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                    ),
                  ),
                  LoadingPage(visible: true)
                ],
              )
            : showSettingPage
                ? Stack(
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          color: AppTheme.white,
                          height: height,
                          width: width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ImageAsset.ic_permission_camera),
                              const SizedBox(height: 24),
                              TextLabel(
                                text: translate('qrcode_page.permission.title'),
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.title),
                                color: AppTheme.black,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              const SizedBox(height: 16),
                              TextLabel(
                                text: translate(
                                    'qrcode_page.permission.description'),
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.large),
                                color: AppTheme.black,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Container(
                                color: AppTheme.white,
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 20),
                                child: Button(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    shadowColor: Colors.transparent,
                                    backgroundColor: AppTheme.blueD,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(200)),
                                    ),
                                  ),
                                  text: translate('button.setting'),
                                  onPressed: onPressedGoToSetting,
                                  textColor: Colors.white,
                                ),
                              )
                            ],
                          )),
                      QrCodeAppBar(
                        onPressedBackButton: onPressedBackButton,
                        isDenied: true,
                      ),
                    ],
                  )
                : Stack(
                    children: [
                      BlocListener<CheckInCubit, CheckInState>(
                        listener: (context, state) {
                          switch (state.runtimeType) {
                            case ScanQrcodeCouponLoading:
                              actionScanQrcodeCouponLoading();
                              break;
                            case ScanQrcodeCouponSuccess:
                              actionScanQrcodeCouponSuccess(
                                  state.scanQrcodeCoupon);
                              break;
                            case ScanQrcodeCouponFailure:
                              actionScanQrcodeCouponFailure();
                              break;
                            default:
                              break;
                          }
                        },
                        child: _buildQrView(context),
                      ),
                      renderAppbar(),
                      renderTextPosition(
                        position: height * 0.15,
                        text: translate('qrcode_page.title'),
                        fontSize:
                            Utilities.sizeFontWithDesityForDisplay(context, 48),
                        fontWeight: FontWeight.bold,
                      ),
                      renderTextPosition(
                        position: height * 0.225,
                        text: translate(
                            "check_in_page.scan_qrcode.scan_qrcode_view_detail"),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.big),
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.width * 0.75
        : MediaQuery.of(context).size.width * 0.75;
    return QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        overlay: QrScannerOverlayShape(
          borderColor: AppTheme.white,
          borderRadius: 12,
          borderLength: scanArea / 10,
          borderWidth: 10,
          cutOutSize: scanArea,
        ));
  }

  Widget renderAppbar() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Positioned(
      top: height * 0.05,
      child: Container(
        width: width,
        height: heightAppbar,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onPressedBackButton,
              child: Container(
                width: 40,
                height: heightAppbar,
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(200)),
                child: Center(
                  child: Icon(Icons.arrow_back, color: AppTheme.blueD),
                ),
              ),
            ),
            const SizedBox(),
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget renderTextPosition({
    required double position,
    required String text,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    final width = MediaQuery.of(context).size.width;
    return Positioned(
      top: position,
      child: Container(
        width: width,
        child: TextLabel(
          text: text,
          color: AppTheme.white,
          textAlign: TextAlign.center,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
