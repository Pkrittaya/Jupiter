import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/pages/payment/cubit/payment_cubit.dart';
import 'package:jupiter/src/presentation/pages/payment_kbank/cubit/payment_k_bank_cubit.dart';
import 'package:jupiter/src/presentation/widgets/custom_appbar.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:web_view_custom/web_view_custom.dart';
import '../../../apptheme.dart';
import 'package:jupiter_api/data/data_models/response/kbank/kbank_charge.dart';
import 'package:jupiter_api/data/data_models/response/kbank/kbank_token.dart';
import 'dart:convert';
import '../../../firebase_log.dart';

class PaymentKBankPage extends StatefulWidget {
  const PaymentKBankPage({super.key, this.appBar});
  final bool? appBar;

  @override
  State<PaymentKBankPage> createState() => _PaymentKBankPageState();
}

class _PaymentKBankPageState extends State<PaymentKBankPage> {
  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
    BlocProvider.of<PaymentKBankCubit>(context).resetState();
    initWebView();
  }

  tokenReceiver(String jsonString) {
    debugPrint("JSSS $jsonString");
  }

  initWebView() async {
    // pullToRefreshController = PullToRefreshController(
    //   options: PullToRefreshOptions(
    //     color: Colors.blue,
    //   ),
    //   onRefresh: () async {
    //     if (Platform.isAndroid) {
    //       webViewController?.reload();
    //     } else if (Platform.isIOS) {
    //       webViewController?.loadUrl(
    //           urlRequest: URLRequest(url: await webViewController?.getUrl()));
    //     }
    //   },
    // );
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  // InAppWebViewController? webViewController;
  // InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
  //     crossPlatform: InAppWebViewOptions(
  //       useShouldOverrideUrlLoading: true,
  //       mediaPlaybackRequiresUserGesture: false,
  //     ),
  //     android: AndroidInAppWebViewOptions(
  //       useHybridComposition: true,
  //     ),
  //     ios: IOSInAppWebViewOptions(
  //       allowsInlineMediaPlayback: true,
  //     ));

  // wf.WebViewController Wcontroller = wf.WebViewController()
  //   ..setJavaScriptMode(wf.JavaScriptMode.unrestricted)
  //   ..addJavaScriptChannel(
  //     'KPayment',
  //     onMessageReceived: (jsonString) {
  //       debugPrint("messageRe");
  //     },
  //   )
  //   ..setBackgroundColor(const Color(0x00000000))
  //   ..setNavigationDelegate(
  //     wf.NavigationDelegate(
  //       onProgress: (int progress) {
  //         // Update loading bar.
  //       },
  //       onPageStarted: (String url) {
  //         debugPrint("onPageStarted $url");
  //       },
  //       onPageFinished: (String url) {
  //         debugPrint("onPageFinished $url");
  //       },
  //       onWebResourceError: (wf.WebResourceError error) {},
  //       onNavigationRequest: (wf.NavigationRequest request) {
  //         debugPrint("NavigationRequest $request");
  //         debugPrint("NavigationRequest ${request.url}}");
  //         if (request.url.startsWith('https://www.youtube.com/')) {
  //           return wf.NavigationDecision.prevent;
  //         }
  //         return wf.NavigationDecision.navigate;
  //       },
  //     ),
  //   );
  //   ..loadRequest(Uri.parse(
  //       'https://dev-kpaymentgateway.kasikornbank.com/ui/v2/index.html#mobile-payment/pkey_test_21610v5pRej3WBmTEPYylxNKSZD24D2rgUn2z?submitText=Add Credit Card &lang=th&callbacktype=app&theme=green&mid=401240932443001'));

  // ..loadFlutterAsset('assets/payments/kbank.html');

  // late PullToRefreshController pullToRefreshController;
  // final GlobalKey webViewKey = GlobalKey();
  String url =
      'https://dev-kpaymentgateway.kasikornbank.com/ui/v2/index.html#mobile-payment/pkey_test_21610v5pRej3WBmTEPYylxNKSZD24D2rgUn2z?submitText=Add Credit Card &lang=th&callbacktype=app&theme=green&mid=401240932443001';
  late WebViewController webViewController;
  @override
  Widget build(BuildContext context) {
    var c = context;
    return Scaffold(
      appBar: (widget.appBar == true)
          ? AppBar(
              bottomOpacity: 0.0,
              elevation: 0.0,
              backgroundColor: AppTheme.white,
              iconTheme: const IconThemeData(
                color: AppTheme.blueDark, //change your color here
              ),
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
                  onPressed: onPressedBackButton),
              centerTitle: true,
              title: TextLabel(
                text: translate("app_title.add_payment"),
                color: AppTheme.blueDark,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.title),
                fontWeight: FontWeight.bold,
              ))
          : CustomAppBar(
              appBarHeight: 120,
              title: translate("app_title.add_payment"),
            ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: AppTheme.white,
        child: BlocBuilder<PaymentKBankCubit, PaymentKBankState>(
          builder: (context, state) {
            debugPrint("PaymentState ${state.runtimeType}");
            switch (state.runtimeType) {
              case PaymentKBankInitial:
                return WebViewCustom(
                  onMapViewCreated: (controller) async {
                    webViewController = controller;
                    webViewController.setUrl(url: url);
                    var a = await webViewController.getToken();
                    debugPrint("Token ${a}");
                    debugPrint(
                        "Token ${KBankToken.fromJson(jsonDecode(a)).token}");
                    var re = KBankToken.fromJson(jsonDecode(a));
                    if (re.token != '') {
                      BlocProvider.of<PaymentKBankCubit>(c)
                          .verifyCard(re.token);
                    }
                  },
                );
              case PaymentKBankVerifyCardLoadingSuccess:
                return WebViewCustom(
                  onMapViewCreated: (controller) async {
                    String urlRedirect = state.verifyCardEntity?.url ?? '';
                    controller.setNewUrl(url: urlRedirect);
                    var a = await controller.getToken();
                    // try {
                    debugPrint("Token ${a}");
                    debugPrint(
                        "Token ${KBankCharge.fromJson(jsonDecode(a)).token}");
                    var re = KBankCharge.fromJson(jsonDecode(a));
                    debugPrint("Token STATUS ${re.status}");
                    debugPrint(
                        "Token STATUS RUNTIMETYPE ${re.status.runtimeType}");
                    if (re.status != null) {
                      if ((re.status ?? '') == "true") {
                        debugPrint("PaymentAddCreditCardResult--");

                        BlocProvider.of<PaymentCubit>(context)
                            .loadCreditCardList();
                        debugPrint("PaymentAddCreditCardResult");
                        Navigator.pop(context);
                      } else {
                        Future.delayed(const Duration(milliseconds: 2000), () {
                          Utilities.alertOneButtonAction(
                            context: context,
                            type: AppAlertType.DEFAULT,
                            isForce: true,
                            title: translate('alert.title.default'),
                            description: translate('alert.description.default'),
                            textButton: translate('button.try_again'),
                            onPressButton: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          );
                        });
                      }
                    }
                    // } catch (e) {
                    //   debugPrint("Token KBankCharge SomeThingWrong");
                    // }
                  },
                );
              case PaymentKBankVerifyCardLoading:
                return Center(
                  child: const CircularProgressIndicator(
                    color: AppTheme.lightBlue,
                    strokeCap: StrokeCap.round,
                  ),
                );
              case PaymentKBankVerifyCardLoadingFailure:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextLabel(
                        text: translate('alert.title.default'),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.superlarge),
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          backgroundColor: AppTheme.blueD,
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(200)),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: TextLabel(
                          text: translate('button.try_again'),
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.normal),
                          fontWeight: FontWeight.w700,
                          color: AppTheme.white,
                        ),
                      ),
                    ],
                  ),
                );
              default:
                return WebViewCustom(
                  onMapViewCreated: (controller) async {
                    controller.setUrl(url: url);
                    var a = await controller.getToken();
                    debugPrint("Token ${a}");
                    debugPrint(
                        "Token ${KBankToken.fromJson(jsonDecode(a)).token}");
                    var re = KBankToken.fromJson(jsonDecode(a));
                    if (re.token != '') {
                      BlocProvider.of<PaymentKBankCubit>(context)
                          .verifyCard(re.token);
                    }
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
