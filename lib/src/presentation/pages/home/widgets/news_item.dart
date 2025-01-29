import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:jupiter_api/domain/entities/news_entity.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../apptheme.dart';
import '../../../widgets/icon_with_text.dart';
import '../../../widgets/text_label.dart';

class NewsItem extends StatelessWidget {
  NewsItem(
      {super.key,
      required this.newsEntity,
      required this.isLastest,
      required this.onCheckClick});
  final NewsEntity? newsEntity;
  final bool isLastest;
  final bool Function({bool check, bool click}) onCheckClick;

  Future<void> _launchInWebViewOrVC(String urlLink) async {
    try {
      Uri url = Uri.parse(urlLink);
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {}
    onCheckClick(check: false, click: false);
  }

  String getDateFormat(String dateForApi) {
    try {
      if (dateForApi != '') {
        DateFormat inputFormat = DateFormat('yyyy/MM/dd');
        DateTime dateTime = inputFormat.parse(dateForApi);
        DateFormat outputFormat = DateFormat('dd MMM yyyy');
        String outputDate = outputFormat.format(dateTime);
        return outputDate; // Output: 20 Jun 2023
      }
      return dateForApi;
    } catch (e) {
      return dateForApi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 15,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                if (!(onCheckClick())) {
                  onCheckClick(check: false, click: true);
                  _launchInWebViewOrVC(newsEntity?.linkInformation ?? '');
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: ImageNetworkJupiter(
                          url: newsEntity?.imageUrl ?? '',
                          fit: BoxFit.contain,
                        ),
                        // child: Image.network(
                        //   newsEntity?.imageUrl ?? '',
                        //   fit: BoxFit.contain,
                        // ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width * 0.520)
                          .floorToDouble(),
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextLabel(
                                text: newsEntity?.header.trim() ?? '',
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.normal),
                                color: AppTheme.blueDark,
                                fontWeight: FontWeight.w700,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              TextLabel(
                                text: newsEntity?.body.trim() ?? '',
                                fontSize:
                                    Utilities.sizeFontWithDesityForDisplay(
                                        context, AppFontSize.normal),
                                color: AppTheme.black,
                                fontWeight: FontWeight.w400,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          IconWithText(
                            textColor: AppTheme.black40,
                            textSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.little),
                            iconSize: 12,
                            icon: Icons.calendar_month,
                            text: getDateFormat(newsEntity?.adCreate ?? ''),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: isLastest ? 3 : 10)
      ],
    );
  }
}
