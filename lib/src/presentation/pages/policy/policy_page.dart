import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/term_and_condition_entity.dart';
import 'package:jupiter/src/presentation/pages/policy/cubit/policy_cubit.dart';
import 'package:jupiter/src/presentation/widgets/loading_page.dart';
import 'package:jupiter/src/utilities.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({super.key});

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  bool loadingPage = false;
  TermAndConditionEntity? termAndConditionEntity;
  ScrollController scrollController = ScrollController();

  void onPressedBackButton(BuildContext context) {
    Navigator.of(context).pop();
  }

  void actionPolicyLoading() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!loadingPage) {
        setState(() {
          loadingPage = true;
        });
      }
    });
  }

  void actionPolicySuccess(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        termAndConditionEntity = state.policyEntity;
      }
    });
  }

  void actionPolicyFailure(state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
        BlocProvider.of<PolicyCubit>(context).resetStatetoInital();
        Utilities.alertOneButtonAction(
          context: context,
          type: AppAlertType.DEFAULT,
          isForce: true,
          title: translate('alert.title.default'),
          description: state.message ?? translate('alert.description.default'),
          textButton: translate('button.try_again'),
          onPressButton: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      }
    });
  }

  void actionResetInitial() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loadingPage) {
        setState(() {
          loadingPage = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    try {
      BlocProvider.of<PolicyCubit>(context).getPolicy();
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (loadingPage) {
          setState(() {
            loadingPage = false;
          });
          BlocProvider.of<PolicyCubit>(context).resetStatetoInital();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppTheme.white,
          appBar: AppBar(
            backgroundColor: AppTheme.white,
            bottomOpacity: 0.0,
            elevation: 0.0,
            iconTheme: const IconThemeData(
              color: AppTheme.blueDark,
            ),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppTheme.blueDark),
                onPressed: () {
                  onPressedBackButton(context);
                }),
            centerTitle: true,
            // title: TextLabel(
            //   text: translate('security_page.legal.term'),
            //   color: AppTheme.blueDark,
            //   fontSize: Utilities.sizeFontWithDesityForDisplay(
            //       context, AppFontSize.title),
            //   fontWeight: FontWeight.w700,
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            // ),
            title: Html(
                shrinkWrap: true,
                data: termAndConditionEntity?.header ??
                    translate('security_page.legal.term'),
                style: {
                  'header': Style(
                      color: AppTheme.blueDark,
                      fontSize: FontSize.xxLarge,
                      fontWeight: FontWeight.bold),
                }),
          ),
          body: BlocBuilder<PolicyCubit, PolicyState>(
            builder: (BuildContext context, state) {
              switch (state.runtimeType) {
                case PolicyLoading:
                  actionPolicyLoading();
                  break;
                case PolicySuccess:
                  actionPolicySuccess(state);
                  break;
                case PolicyFailure:
                  actionPolicyFailure(state);
                  break;
                default:
                  actionResetInitial();
                  break;
              }
              return renderPolicyPage();
            },
          ),
        ),
        LoadingPage(visible: loadingPage)
      ],
    );
  }

  Widget renderPolicyPage() {
    double heightDevice = MediaQuery.of(context).size.height;
    double heightAppbar = AppBar().preferredSize.height;
    double heightPage =
        heightDevice - heightAppbar - (Platform.isIOS ? 56 : 40);
    double paddingHorizontal = 16;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            child: Container(
              height: heightPage,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  child: Html(
                    data:
                        termAndConditionEntity?.body.replaceAll("<br />", '') ??
                            '',
                    style: {
                      'table': Style(
                        backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                      ),
                      'tr': Style(
                        border: Border(bottom: BorderSide(color: Colors.grey)),
                      ),
                      'th': Style(
                        padding: HtmlPaddings.all(6),
                        backgroundColor: Colors.grey,
                      ),
                      'td': Style(
                        padding: HtmlPaddings.all(6),
                        alignment: Alignment.topLeft,
                      ),
                      'h1': Style(
                          color: AppTheme.blueDark,
                          fontSize: FontSize.xxLarge,
                          fontWeight: FontWeight.bold),
                      'h2': Style(
                          color: AppTheme.blueDark,
                          fontSize: FontSize.xLarge,
                          fontWeight: FontWeight.bold),
                      'b': Style(
                          color: AppTheme.blueDark,
                          fontSize: FontSize.xLarge,
                          fontWeight: FontWeight.bold),
                      'li': Style(
                          color: AppTheme.black,
                          fontSize: FontSize.xLarge,
                          fontWeight: FontWeight.normal),
                      'h5': Style(
                          maxLines: 2, textOverflow: TextOverflow.ellipsis),
                      'p': Style(
                          color: AppTheme.black,
                          fontSize: FontSize.xLarge,
                          fontWeight: FontWeight.normal),
                    },
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
