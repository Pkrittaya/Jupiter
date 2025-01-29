import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/button.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/notification_data_news_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key, required this.data});

  final NotificationNewsDataEntity? data;

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  String getDateFormat(String dateFromApi) {
    try {
      if (dateFromApi != '') {
        // DateFormat inputFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
        DateTime dateTime = DateTime.parse(dateFromApi);
        DateFormat outputFormat = DateFormat('dd MMM yyyy HH:mm');
        String outputDate = outputFormat.format(dateTime.toLocal());
        return outputDate; // Output: 20 Jun 2023
      }
      return dateFromApi;
    } catch (e) {
      return dateFromApi;
    }
  }

  Future<void> _launchInWebViewOrVC(String urlLink) async {
    Uri url = Uri.parse(urlLink);
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $urlLink');
    }
  }

  void onPressedLink(BuildContext context) {
    _launchInWebViewOrVC(widget.data?.linkInformation ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageNetworkJupiter(
                  url: widget.data?.image ?? '',
                  width: MediaQuery.of(context).size.width,
                  heightLoading: MediaQuery.of(context).size.height * 0.35,
                  fit: BoxFit.cover,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextLabel(
                          text: widget.data?.messageTitle ?? '',
                          color: AppTheme.blueDark,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.title),
                          fontWeight: FontWeight.w700,
                          // maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextLabel(
                          text: getDateFormat(widget.data?.messageCreate ?? ''),
                          color: AppTheme.gray9CA3AF,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.normal),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextLabel(
                          text: widget.data?.messageBody ?? '',
                          color: AppTheme.gray9CA3AF,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.big),
                          // maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.11,
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: true,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: AppTheme.white,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.11,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Button(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  backgroundColor: AppTheme.blueD,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                  ),
                ),
                text:
                    translate('notification_page.notification_detail.see_more'),
                onPressed: () => onPressedLink(context),
                textColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
