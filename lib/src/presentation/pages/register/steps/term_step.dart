import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter_api/domain/entities/term_and_condition_entity.dart';

class TermStep extends StatefulWidget {
  const TermStep({
    required this.termAndConditionEntity,
    required this.scrollController,
    required this.isActiveAccept,
    required this.scrollControllerListen,
    super.key,
  });

  final TermAndConditionEntity? termAndConditionEntity;
  final ScrollController scrollController;
  final bool isActiveAccept;
  final Function() scrollControllerListen;
  @override
  State<TermStep> createState() => _TermStepState();
}

class _TermStepState extends State<TermStep> {
  GlobalKey scroller = GlobalKey(debugLabel: 'scroller');
  void initState() {
    widget.scrollController.addListener(widget.scrollControllerListen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    double heightAppbar = AppBar().preferredSize.height;
    double heightPage = heightDevice - heightAppbar - 40;
    double paddingHorizontal = 40;

    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            child: Html(
                shrinkWrap: true,
                data: widget.termAndConditionEntity?.header ?? '',
                style: {
                  'header': Style(
                      color: AppTheme.blueDark,
                      fontSize: FontSize(32.0),
                      fontWeight: FontWeight.bold),
                }),
          ),
          // Container(
          //   alignment: Alignment.center,
          //   height: 70,
          //   padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          //   child: TextLabel(
          //     color: AppTheme.blueDark,
          //     text: translate('register_page.term'),
          //     fontWeight: FontWeight.bold,
          //     fontSize: Utilities.sizeFontWithDesityForDisplay(
          //         context, AppFontSize.large),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            child: Scrollbar(
              thickness: 4, //width of scrollbar
              radius: const Radius.circular(5), //corner radius of scrollbar
              scrollbarOrientation: ScrollbarOrientation.right,
              child: Container(
                height: heightPage * 0.65,
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();
                    return true;
                  },
                  child: SingleChildScrollView(
                    key: scroller,
                    controller: widget.scrollController,
                    scrollDirection: Axis.vertical,
                    child: Html(
                      data: widget.termAndConditionEntity?.body
                              .replaceAll("<br />", '') ??
                          '',
                      style: {
                        'table': Style(
                          backgroundColor:
                              Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                        ),
                        'tr': Style(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey)),
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
          ),
        ],
      ),
    );
  }
}
