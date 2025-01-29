import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/widget_key.dart';
import 'package:jupiter_api/domain/entities/credit_card_entity.dart';
import 'package:jupiter/src/injection.dart';
import 'package:jupiter/src/presentation/pages/payment/cubit/payment_cubit.dart';
import 'package:jupiter/src/presentation/pages/payment/widgets/button_add_card.dart';
import 'package:jupiter/src/presentation/pages/payment/widgets/list_credit_card.dart';
import 'package:jupiter/src/presentation/pages/payment_detail/payment_detail_page.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';
import '../../../firebase_log.dart';

class PaymentPageWrapperProvider extends StatelessWidget {
  const PaymentPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaymentCubit>(),
      child: const PaymentPage(),
    );
  }
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<CreditCardEntity> creditCardList = List.empty(growable: true);
  bool loadingPage = false;

  @override
  void initState() {
    FirebaseLog.logPage(this);
    super.initState();
    BlocProvider.of<PaymentCubit>(context).loadCreditCardList();
  }

  void onPressedBackButton() {
    Navigator.of(context).pop();
  }

  void onPressdItemPayment(CreditCardEntity creditCardEntity) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PaymentDetailPage(creditCardEntity: creditCardEntity);
    }));
  }

  void actionPaymentCreditCardLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionPaymentCreditCardLoadingSuccess(state) {
    creditCardList.clear();
    creditCardList.addAll(state.creditCardList ?? List.empty());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
      }
    });
  }

  void actionPaymentCreditCardLoadingFailure() {
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
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: AppTheme.blueDark, //change your color here
        ),
        leading: IconButton(
            key: WidgetKey.BT_BACK_PAGE,
            icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
            onPressed: onPressedBackButton),
        centerTitle: true,
        title: TextLabel(
          text: translate('app_title.payment'),
          color: AppTheme.blueDark,
          fontSize: Utilities.sizeFontWithDesityForDisplay(
              context, AppFontSize.title),
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BlocBuilder<PaymentCubit, PaymentState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case PaymentCreditCardLoading:
                  actionPaymentCreditCardLoading();
                  break;
                case PaymentCreditCardLoadingSuccess:
                  actionPaymentCreditCardLoadingSuccess(state);
                  break;
                case PaymentCreditCardLoadingFailure:
                  actionPaymentCreditCardLoadingFailure();
                  break;
              }
              return ListCreditCard(
                creditCardList: creditCardList,
                onPressdItemPayment: onPressdItemPayment,
                loading: loadingPage,
              );
            },
          ),
          ButtonAddCard(),
        ],
      ),
    );
  }
}
