import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/check_in/check_in_page.dart';
import 'package:jupiter/src/presentation/pages/scan_qrcode/cubit/scan_qr_code_cubit.dart';
import 'package:jupiter/src/presentation/pages/scan_qrcode/widgets/qrcode_appbar.dart';
import 'package:jupiter/src/presentation/pages/scan_qrcode/widgets/qrcode_input_charger_code.dart';
import 'package:jupiter/src/presentation/pages/scan_qrcode/widgets/qrcode_text_position.dart';
import 'package:jupiter/src/presentation/widgets/button.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../firebase_log.dart';
import '../../../injection.dart';

class ScanQrCodeWrapperProvider extends StatelessWidget {
  const ScanQrCodeWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ScanQrCodeCubit>(),
      child: const ScanQRCodePage(),
    );
  }
}

class ScanQRCodePage extends StatefulWidget {
  const ScanQRCodePage({
    Key? key,
    this.fromFleet = false,
    this.fleetNo = -1,
    this.fleetType = null,
  }) : super(key: key);

  final bool? fromFleet;
  final int? fleetNo;
  final String? fleetType;
  @override
  _ScanQRCodePageState createState() => _ScanQRCodePageState();
}

class _ScanQRCodePageState extends State<ScanQRCodePage>
    with TickerProviderStateMixin {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QRCODE');
  DateTime? lastScan;
  String? textTest;
  // TAB
  late TabController tabController;
  int indexTab = 0;
  final TextEditingController chargerCodeController = TextEditingController();
  // SHOW SETTING PAGE
  bool showSettingPage = false;
  bool loadingPage = true;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
    requestPermission();
    initTabOptionController();
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
  void dispose() {
    controller?.dispose();
    tabController.dispose();
    super.dispose();
    debugPrint('ScanQrDispose');
  }

  @override
  void activate() {
    super.activate();
    debugPrint('ScanQrActivate');
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint('ScanQrDeActivate');
  }

  void initTabOptionController() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
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

  void onSubmitTextField(String value) {
    if (value.isNotEmpty) {
      switch (widget.fleetType) {
        case FleetType.CARD:
          Navigator.of(context).pop(value);
        case FleetType.OPERATION:
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return JupiterChargingCheckInPage(
              qrCodeData: value,
              fromFleet: true,
              fleetNo: widget.fleetNo,
              fleetType: FleetType.OPERATION,
            );
          }));
        default:
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return JupiterChargingCheckInPage(qrCodeData: value);
          }));
      }
    }
  }

  void onTapTabMenu(int index) {
    setState(() {
      indexTab = index;
    });
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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      textTest = result!.code ?? '';
      final currentScan = DateTime.now();
      if (lastScan == null ||
          currentScan.difference(lastScan!) > const Duration(seconds: 3)) {
        lastScan = currentScan;
        switch (widget.fleetType) {
          case FleetType.CARD:
            Navigator.of(context).pop(result?.code ?? '');
          case FleetType.OPERATION:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return JupiterChargingCheckInPage(
                qrCodeData: result?.code ?? '',
                fromFleet: true,
                fleetNo: widget.fleetNo,
                fleetType: FleetType.OPERATION,
              );
            }));
          default:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return JupiterChargingCheckInPage(qrCodeData: result?.code ?? '');
            }));
        }
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return PopScope(
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
                      _buildQrView(context),
                      QrCodeAppBar(
                        onPressedBackButton: onPressedBackButton,
                      ),
                      QrCodeTextPosition(
                        position: height * 0.15,
                        text: indexTab == 0
                            ? translate('qrcode_page.title')
                            : translate('qrcode_page.input.title'),
                        fontSize:
                            Utilities.sizeFontWithDesityForDisplay(context, 48),
                        fontWeight: FontWeight.bold,
                      ),
                      QrCodeTextPosition(
                        position: height * 0.225,
                        text: indexTab == 0
                            ? translate('qrcode_page.description')
                            : translate('qrcode_page.input.description'),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.big),
                        fontWeight: FontWeight.normal,
                      ),
                      QrCodeInputChargerCode(
                        indexTab: indexTab,
                        chargerCodeController: chargerCodeController,
                        onSubmitTextField: onSubmitTextField,
                      ),
                      // QrCodeTabMenu(
                      //   fromFleet: widget.fromFleet,
                      //   fleetType: widget.fleetType,
                      //   tabController: tabController,
                      //   indexTab: indexTab,
                      //   onTapTabMenu: onTapTabMenu,
                      // )
                    ],
                  ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.width * 0.75
        : MediaQuery.of(context).size.width * 0.75;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        // onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        overlay: indexTab == 0
            ? QrScannerOverlayShape(
                borderColor: AppTheme.white,
                borderRadius: 12,
                borderLength: scanArea / 10,
                borderWidth: 10,
                cutOutSize: scanArea,
              )
            : null);
  }
}
