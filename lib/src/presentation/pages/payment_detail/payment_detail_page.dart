import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/credit_card_entity.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/presentation/pages/payment/cubit/payment_cubit.dart';
import 'package:jupiter/src/presentation/pages/payment_detail/cubit/payment_detail_cubit.dart';
import 'package:jupiter/src/presentation/widgets/button.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../firebase_log.dart';

class PaymentDetailPageWrapperProvider extends StatelessWidget {
  const PaymentDetailPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaymentCubit>(),
      child: const PaymentDetailPage(),
    );
  }
}

class PaymentDetailPage extends StatefulWidget {
  const PaymentDetailPage({super.key, this.creditCardEntity});
  final CreditCardEntity? creditCardEntity;
  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  bool isDefault = false;
  bool isLoading = false;
  @override
  void initState() {
    FirebaseLog.logPage(this);
    isDefault = widget.creditCardEntity?.defalut ?? false;
    super.initState();
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  void onPressdDeleteButton() {
    // if (!(widget.creditCardEntity?.defalut ?? false)) {
    Utilities.alertTwoButtonAction(
      context: context,
      type: AppAlertType.WARNING,
      title: translate('payment_page.alert_confirm_delete_title'),
      description: translate('payment_page.alert_confirm_delete_message'),
      textButtonLeft: translate('button.cancel'),
      textButtonRight: translate('button.confirm'),
      onPressButtonLeft: () {
        Navigator.of(context).pop();
      },
      onPressButtonRight: () {
        BlocProvider.of<PaymentDetailCubit>(context).fetchDeleteCreditCard(
          widget.creditCardEntity ??
              CreditCardEntity(
                cardBrand: '',
                cardExpired: '',
                display: '',
                cardHashing: '',
                type: '',
                name: '',
                defalut: false,
              ),
        );
        Navigator.of(context).pop();
      },
    );
    // }
  }

  String formatCreditCardDisplay(String display) {
    return display.substring(display.length - 4);
  }

  String formatCreditCardExpries(String dateString) {
    try {
      debugPrint(dateString);
      String year = dateString.substring(0, 4);
      String month = dateString.substring(4, 6);
      String formattedDate = month + '/' + year;
      return formattedDate;
    } catch (e) {
      return 'XX/XX';
    }
  }

  void onChangeSetDefault(value) {
    if ((widget.creditCardEntity?.defalut ?? false) == false) {
      setState(() {
        isDefault = true;
        isLoading = true;
      });
      Future.delayed(const Duration(milliseconds: 100), () {
        BlocProvider.of<PaymentDetailCubit>(context).fetchSetDefaultCard(
          cardHashing: widget.creditCardEntity?.cardHashing ?? '',
          defalut: value,
        );
      });
    }
  }

  void actionPaymentCreditCardDeleteStart() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  void actionPaymentCreditCardDeleteSuccess() {
    if (isLoading) {
      BlocProvider.of<PaymentDetailCubit>(context).resetStateToInitial();
      BlocProvider.of<PaymentCubit>(context).loadCreditCardList();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  void actionPaymentCreditCardDeleteFailure(state) {
    if (isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
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
      });
    }
  }

  void actionPaymentSetDefaultCardLoading() {
    isLoading = true;
  }

  void actionPaymentSetDefaultCardSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PaymentDetailCubit>(context).resetStateToInitial();
      if (isLoading) {
        setState(() {
          isLoading = false;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.SUCCESS,
          isForce: true,
          title: translate('alert.title.success'),
          description: translate('alert.description.set_default_success'),
          textButton: translate('button.close'),
          onPressButton: () {
            BlocProvider.of<PaymentCubit>(context).loadCreditCardList();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  void actionPaymentSetDefaultCardFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoading) {
        setState(() {
          isLoading = false;
        });
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: state.message ?? translate('alert.description.default'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            BlocProvider.of<PaymentDetailCubit>(context).resetStateToInitial();
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.white,
            bottomOpacity: 0.0,
            elevation: 0.0,
            iconTheme: const IconThemeData(
              color: AppTheme.blueDark, //change your color here
            ),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
                onPressed: onPressedBackButton),
            centerTitle: true,
            title: TextLabel(
              text: translate('app_title.details'),
              color: AppTheme.blueDark,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.title),
              fontWeight: FontWeight.w700,
            ),
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BlocBuilder<PaymentDetailCubit, PaymentDetailState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case PaymentCreditCardDeleteStart:
                      actionPaymentCreditCardDeleteStart();
                      break;
                    case PaymentCreditCardDeleteSuccess:
                      actionPaymentCreditCardDeleteSuccess();
                      break;
                    case PaymentCreditCardDeleteFailure:
                      actionPaymentCreditCardDeleteFailure(state);
                      break;
                    case PaymentSetDefaultCardLoading:
                      actionPaymentSetDefaultCardLoading();
                      break;
                    case PaymentSetDefaultCardSuccess:
                      actionPaymentSetDefaultCardSuccess();
                      break;
                    case PaymentSetDefaultCardFailure:
                      actionPaymentSetDefaultCardFailure(state);
                      break;
                  }
                  return Container(
                    color: AppTheme.white,
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppTheme.lightBlue10,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(1, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Container(
                                    child: Utilities.assetCreditCard(
                                        cardBrand: widget
                                                .creditCardEntity?.cardBrand ??
                                            '',
                                        width: 45,
                                        height: 45)),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  TextLabel(
                                    text: '✱✱✱✱ ✱✱✱✱ ✱✱✱✱',
                                    color: AppTheme.blueDark,
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.supermini),
                                    letterSpacing: 3,
                                  ),
                                  const SizedBox(width: 8),
                                  TextLabel(
                                    text: formatCreditCardDisplay(
                                        widget.creditCardEntity?.display ?? ''),
                                    color: AppTheme.blueDark,
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                            context, AppFontSize.big),
                                    letterSpacing: 2,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              TextLabel(
                                text: translate('payment_page.expries_on'),
                                color: AppTheme.gray9CA3AF,
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.little),
                              ),
                              TextLabel(
                                text: formatCreditCardExpries(
                                    widget.creditCardEntity?.cardExpired ?? ''),
                                color: AppTheme.gray9CA3AF,
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.little),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextLabel(
                                text:
                                    translate('payment_page.set_default_card'),
                                color: AppTheme.blueDark,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.big),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 30,
                              child: Transform.scale(
                                scale: 0.7,
                                alignment: Alignment.centerLeft,
                                child: CupertinoSwitch(
                                  value: isDefault,
                                  activeColor: AppTheme.blueD,
                                  onChanged: onChangeSetDefault,
                                ),
                              ),
                            ),
                            //  Switch(
                            //     materialTapTargetSize:
                            //         MaterialTapTargetSize.shrinkWrap,
                            //     value: isDefault,
                            //     activeColor: AppTheme.blueD,
                            //     onChanged: onChangeSetDefault),
                            // ),
                            TextLabel(
                              text: translate(
                                  'ev_information_add_page.default_vehicle.default'),
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.little),
                              color: isDefault
                                  ? AppTheme.blueDark
                                  : AppTheme.gray9CA3AF,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              Container(
                color: AppTheme.white,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.11,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Button(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                    backgroundColor: AppTheme.red,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                    ),
                  ),
                  text: translate('button.delete'),
                  onPressed: onPressdDeleteButton,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        LoadingPage(visible: isLoading)
      ],
    );
  }
}
