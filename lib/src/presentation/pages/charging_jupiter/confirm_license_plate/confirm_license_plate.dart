import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:app_settings/app_settings.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image/image.dart' as img;
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/confirm_license_plate/cubit/ocr_cubit.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/confirm_license_plate/widgets/ocr_go_to_setting_page.dart';
import 'package:jupiter/src/presentation/pages/charging_jupiter/confirm_license_plate/widgets/ocr_widget_loading.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../firebase_log.dart';

class OcrStatus {
  static const String NONE = 'NONE';
  static const String CAPTURING = 'CAPTURING';
  static const String LOADING = 'LOADING';
  static const String APPROVED = 'APPROVED';
  static const String REJECTED = 'REJECTED';
  static const String FAILED = 'FAILED';
}

class ConfirmLicensePlate extends StatefulWidget {
  const ConfirmLicensePlate({
    Key? key,
    required this.license_plate_check,
  }) : super(key: key);

  final String license_plate_check;
  @override
  _ConfirmLicensePlateState createState() => _ConfirmLicensePlateState();
}

class _ConfirmLicensePlateState extends State<ConfirmLicensePlate> {
  // SHOW SETTING PAGE
  double heightAppbar = AppBar().preferredSize.height;
  bool showSettingPage = false;
  bool loadingPage = true;
  double borderSize = 5;
  // IMAGE PATH
  String ocrState = OcrStatus.NONE;
  late CameraController controller;
  late List<CameraDescription> _cameras;
  Color frameColor = AppTheme.white;
  Color startColor = AppTheme.white;
  Color stopColor = AppTheme.lightBlue;
  Color bgColor = AppTheme.grayD4A50.withOpacity(0.3);
  File? fileImage;
  Timer? timer;
  int countLoading = 0;
  String mesLoading = '';

  @override
  void initState() {
    FirebaseLog.logPage(this);
    requestPermission();
    _initializeCameraController(null);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;
    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController(cameraController.description);
    }
  }

  void setTimerLoading() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      String newDot = '';
      for (int i = 0; i < countLoading + 1; i++) {
        newDot = '${newDot} .';
      }
      debugPrint('newDot : ${newDot}');
      setState(() {
        countLoading = countLoading + 1 > 2 ? 0 : countLoading + 1;
        mesLoading = newDot;
      });
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

  Future<void> _initializeCameraController(CameraDescription? des) async {
    try {
      _cameras = await availableCameras();
      controller = CameraController(
        des ?? _cameras[0],
        ResolutionPreset.max,
        enableAudio: false,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });
      controller.lockCaptureOrientation().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } catch (e) {}
  }

  void onPressedBackButton() {
    if (ocrState == OcrStatus.NONE) {
      Navigator.of(context).pop();
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

  Future<void> onPressedCaptureImage() async {
    try {
      if (!controller.value.isInitialized || ocrState != OcrStatus.NONE) {
        return;
      }
      setState(() {
        ocrState = OcrStatus.CAPTURING;
      });
      for (double t = 0.0; t < 1.0; t += 0.05) {
        await Future.delayed(Duration(milliseconds: 10));
        setState(() {
          frameColor = Color.lerp(startColor, stopColor, t)!;
        });
      }
      await controller.takePicture().then((XFile? file) async {
        if (file != null) {
          controller.pausePreview();
          await cropImageReturnBase64(file);
        }
      });
      setTimerLoading();
      BlocProvider.of<OcrCubit>(context)
          .sendImageVerify(fileImage!, widget.license_plate_check);
    } catch (e) {
      onPressedReset(isClearFileimage: true);
    }
  }

  Future<void> cropImageReturnBase64(XFile imageFile) async {
    final bytes = await File(imageFile.path).readAsBytes();
    final image = img.decodeImage(Uint8List.fromList(bytes));
    img.Image? croppedImage = null;
    if (image == null || image == '') {
      return;
    }
    croppedImage = img.copyCrop(
      image,
      x: image.width.floor() - (image.width * 0.95).floor(),
      y: (image.height * 0.325).floor(),
      width: image.width.floor() - ((image.width * 0.05).floor() * 2),
      height: (image.height * 0.4).floor(),
      radius: 0,
    );
    img.Image resized = img.copyResize(croppedImage, width: 800, height: 600);
    try {
      // Save the cropped image to a file
      final imgBytes = Uint8List.fromList(img.encodeJpg(resized));
      final directory = await getTemporaryDirectory();
      final filePath =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}-cropped.jpg';
      final croppedImageFile = File(filePath);
      await croppedImageFile.writeAsBytes(imgBytes).then((value) {
        setState(() {
          fileImage = croppedImageFile;
        });
      });
      debugPrint('Image Path : ${fileImage?.path}');
    } catch (e) {
      return;
    }
  }

  Future<void> onPressedReset({required bool isClearFileimage}) async {
    BlocProvider.of<OcrCubit>(context).resetCubit();
    controller.resumePreview();
    setState(() {
      ocrState = OcrStatus.NONE;
      if (isClearFileimage) {
        fileImage = null;
      }
      frameColor = startColor;
    });
  }

  double getHeightBottom() {
    final height = MediaQuery.of(context).size.height;
    return height * 0.15 > 100 ? height * 0.15 : 100;
  }

  double getHeightCamera() {
    return 250;
  }

  String getTextUnderFrame({required bool isModal}) {
    if (isModal) {
      switch (ocrState) {
        case OcrStatus.APPROVED:
          return translate('check_in_page.verify_ocr.approved');
        case OcrStatus.REJECTED:
          return translate('check_in_page.verify_ocr.rejected');
        case OcrStatus.FAILED:
          return translate('check_in_page.verify_ocr.failed');
        case OcrStatus.LOADING:
          return translate('check_in_page.verify_ocr.des_camera_verify');
        default:
          return '';
      }
    } else {
      switch (ocrState) {
        case OcrStatus.NONE:
          return translate('check_in_page.verify_ocr.des_camera');
        case OcrStatus.CAPTURING:
          return translate('check_in_page.verify_ocr.des_camera_capture');
        default:
          return translate('check_in_page.verify_ocr.des_camera');
      }
    }
  }

  bool showModalProcessingVerifyImage() {
    return (ocrState == OcrStatus.LOADING ||
            ocrState == OcrStatus.APPROVED ||
            ocrState == OcrStatus.REJECTED ||
            ocrState == OcrStatus.FAILED) &&
        fileImage != null;
  }

  Widget getIconFromOcrStatus() {
    switch (ocrState) {
      case OcrStatus.APPROVED:
        return Opacity(
          opacity: 0.75,
          child: Container(
            width: 45,
            height: 45,
            child: Image.asset(
              ImageAsset.ic_alert_success,
            ),
          ),
        );
      case OcrStatus.REJECTED:
        return Opacity(
          opacity: 0.75,
          child: Container(
            width: 45,
            height: 45,
            child: Image.asset(ImageAsset.ic_alert_warning),
          ),
        );
      case OcrStatus.FAILED:
        return Opacity(
          opacity: 0.75,
          child: Container(
            width: 45,
            height: 45,
            child: Image.asset(ImageAsset.ic_alert_warning),
          ),
        );
      case OcrStatus.LOADING:
        return Container(
          width: double.infinity,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  strokeCap: StrokeCap.round,
                ),
              ),
              const SizedBox(height: 8),
              TextLabel(
                text:
                    '${translate('check_in_page.verify_ocr.checking')} ${mesLoading}',
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context,
                  AppFontSize.normal,
                ),
                fontWeight: FontWeight.bold,
                color: AppTheme.white,
              )
            ],
          ),
        );
      default:
        return SizedBox();
    }
  }

  Color getTextColorFromOcrStatus() {
    switch (ocrState) {
      case OcrStatus.APPROVED:
        return AppTheme.green;
      case OcrStatus.REJECTED:
        return AppTheme.red;
      case OcrStatus.FAILED:
        return AppTheme.red;
      case OcrStatus.LOADING:
        return AppTheme.black.withOpacity(0.8);
      default:
        return AppTheme.black.withOpacity(0.8);
    }
  }

  void actionOcrLoading() {
    if (ocrState != OcrStatus.LOADING) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          ocrState = OcrStatus.LOADING;
        });
      });
    }
  }

  Future<void> actionOcrFailure(state) async {
    if (ocrState == OcrStatus.LOADING) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          ocrState = OcrStatus.REJECTED;
          // frameColor = AppTheme.red;
        });
      });
      await Future.delayed(Duration(seconds: 3)).then((value) {
        timer?.cancel();
        // onPressedReset(isClearFileimage: true);
        Navigator.of(context).pop(OcrStatus.REJECTED);
      });
    }
  }

  Future<void> actionOcrSuccess(state) async {
    if (ocrState == OcrStatus.LOADING) {
      timer?.cancel();
      bool status = state.verifyImageOcrEntity.status ?? false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          if (status) {
            ocrState = OcrStatus.APPROVED;
            // frameColor = AppTheme.green80;
          } else {
            ocrState = OcrStatus.REJECTED;
            // frameColor = AppTheme.red;
          }
        });
      });
      if (status) {
        await Future.delayed(Duration(seconds: 2)).then((value) {
          timer?.cancel();
          BlocProvider.of<OcrCubit>(context).resetCubit();
          Navigator.of(context).pop(OcrStatus.APPROVED);
        });
      } else {
        await Future.delayed(Duration(seconds: 3)).then((value) {
          timer?.cancel();
          Navigator.of(context).pop(OcrStatus.REJECTED);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool value) {
        debugPrint('PopScope : ${value}');
        if (!value) {
          onPressedBackButton();
        }
      },
      child: loadingPage
          ? OcrWidgetLoading()
          : showSettingPage
              ? OcrGoToSettingPage(
                  onPressedBackButton: onPressedBackButton,
                  onPressedGoToSetting: onPressedGoToSetting,
                )
              : renderScanObjectScreen(),
    );
  }

  Widget renderScanObjectScreen() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (!controller.value.isInitialized) {
      return OcrWidgetLoading();
    }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: height - getHeightBottom(),
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return CameraPreview(controller);
                  },
                ),
              ),
            ),
            Container(
              height: height - getHeightBottom(),
              margin: EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: bgColor,
                    width: (width * 0.05).ceil().toDouble() + borderSize,
                  ),
                  top: BorderSide(
                    color: bgColor,
                    width: (height * 0.3) + borderSize,
                  ),
                  right: BorderSide(
                    color: bgColor,
                    width: (width * 0.05).ceil().toDouble() + borderSize,
                  ),
                  bottom: BorderSide(
                    color: bgColor,
                    width: height -
                        getHeightBottom() -
                        getHeightCamera() -
                        (height * 0.3) +
                        borderSize,
                  ),
                ),
              ),
            ),
            BlocBuilder<OcrCubit, OcrState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case OcrLoading:
                    actionOcrLoading();
                    break;
                  case OcrFailure:
                    actionOcrFailure(state);
                    break;
                  case OcrSuccess:
                    actionOcrSuccess(state);
                    break;
                  default:
                    break;
                }
                return AnimatedPositioned(
                  top: height * 0.3,
                  duration: Duration(seconds: 3),
                  child: Container(
                    width: width,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          width: width * 0.9,
                          height: getHeightCamera(),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: frameColor,
                              width: borderSize,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: width * 0.9,
                          margin: EdgeInsets.only(top: 16),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextLabel(
                                text: getTextUnderFrame(isModal: false),
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.large),
                                fontWeight: FontWeight.bold,
                                color: AppTheme.white,
                                textAlign: TextAlign.center,
                              ),
                              Visibility(
                                visible: (ocrState == OcrStatus.LOADING ||
                                    ocrState == OcrStatus.CAPTURING),
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  width: 16,
                                  height: 16,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppTheme.lightBlue,
                                      strokeCap: StrokeCap.round,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: height * 0.05,
              child: Container(
                width: width,
                height: heightAppbar,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          borderRadius: BorderRadius.circular(200),
                        ),
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
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: getHeightBottom(),
                color: AppTheme.black,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      borderRadius: BorderRadius.circular(200),
                      color: AppTheme.white,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(200),
                        onTap: () {
                          if (ocrState == OcrStatus.NONE) {
                            onPressedCaptureImage();
                          }
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          child: Center(
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(200),
                                border: Border.all(
                                  color: AppTheme.gray9CA3AF,
                                  width: 2,
                                ),
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: showModalProcessingVerifyImage(),
              child: Container(
                width: width,
                height: height,
                color: AppTheme.black.withOpacity(0.4),
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                color: bgColor,
                                child: fileImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          fit: BoxFit.contain,
                                          File(fileImage!.path),
                                        ),
                                      )
                                    : SizedBox(),
                              ),
                              getIconFromOcrStatus()
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 16),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: getTextColorFromOcrStatus(),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: SizedBox()),
                                TextLabel(
                                  text: getTextUnderFrame(isModal: true),
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.large),
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.white,
                                  textAlign: TextAlign.center,
                                ),
                                Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
