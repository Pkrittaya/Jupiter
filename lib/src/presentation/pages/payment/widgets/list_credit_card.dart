import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter_api/domain/entities/credit_card_entity.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListCreditCard extends StatefulWidget {
  const ListCreditCard({
    Key? key,
    required this.creditCardList,
    required this.onPressdItemPayment,
    required this.loading,
  }) : super(key: key);

  final List<CreditCardEntity> creditCardList;
  final Function(CreditCardEntity) onPressdItemPayment;
  final bool loading;

  @override
  _ListCreditCardState createState() => _ListCreditCardState();
}

class _ListCreditCardState extends State<ListCreditCard> {
  Color expiredColor(String date) {
    DateTime now = DateTime.now();
    int monthNow = int.parse(DateFormat('MM').format(now));
    int yearNow = int.parse(DateFormat('yy').format(now));
    int monthCard = 0;
    int yearCard = 0;
    try {
      final splitted = date.split('/');
      if (splitted[0].isNotEmpty && splitted.length > 1) {
        monthCard = int.parse(splitted[0]);
        yearCard = int.parse(splitted[1]);

        if (yearCard == yearNow) {
          if (monthCard >= monthNow) {
            return AppTheme.gray9CA3AF;
          } else {
            return AppTheme.red;
          }
        } else if (yearCard > yearNow) {
          return AppTheme.gray9CA3AF;
        } else {
          return AppTheme.red;
        }
      } else {
        return AppTheme.gray9CA3AF;
      }
    } catch (e) {
      return AppTheme.gray9CA3AF;
    }
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

  @override
  Widget build(BuildContext context) {
    if (widget.creditCardList.length > 0 && !widget.loading) {
      return Container(
        color: AppTheme.white,
        // padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox();
                  },
                  itemCount: widget.creditCardList.length,
                  itemBuilder: (context, index) {
                    CreditCardEntity creditCard = widget.creditCardList[index];
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppTheme.white,
                                    AppTheme.lightBlue10,
                                  ],
                                ),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  widget.onPressdItemPayment(creditCard);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 16),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 65,
                                            // padding: const EdgeInsets.only(
                                            //     left: 8, right: 8),
                                            child: Utilities.assetCreditCard(
                                              cardBrand: creditCard.cardBrand,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    TextLabel(
                                                      text: '✱✱✱✱ ✱✱✱✱ ✱✱✱✱ ',
                                                      color: AppTheme.blueDark,
                                                      fontSize: Utilities
                                                          .sizeFontWithDesityForDisplay(
                                                              context, 8),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    TextLabel(
                                                      text: creditCard.display
                                                          .substring(creditCard
                                                                  .display
                                                                  .length -
                                                              4),
                                                      color: AppTheme.blueDark,
                                                      fontSize: Utilities
                                                          .sizeFontWithDesityForDisplay(
                                                              context,
                                                              AppFontSize.big),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    TextLabel(
                                                      text: translate(
                                                          'fleet_page.card.expired'),
                                                      color:
                                                          AppTheme.gray9CA3AF,
                                                      fontSize: Utilities
                                                          .sizeFontWithDesityForDisplay(
                                                              context,
                                                              AppFontSize
                                                                  .large),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4),
                                                      child: TextLabel(
                                                        text: formatCreditCardExpries(
                                                            creditCard
                                                                .cardExpired),
                                                        color: expiredColor(
                                                            creditCard
                                                                .cardExpired),
                                                        fontSize: Utilities
                                                            .sizeFontWithDesityForDisplay(
                                                                context,
                                                                AppFontSize
                                                                    .large),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(),
                                          creditCard.defalut
                                              ? Container(
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 6,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              200),
                                                      color:
                                                          AppTheme.lightBlue10),
                                                  child: TextLabel(
                                                    text: translate(
                                                        'ev_information_add_page.default_vehicle.default'),
                                                    color: AppTheme.blueDark,
                                                    fontSize: Utilities
                                                        .sizeFontWithDesityForDisplay(
                                                            context,
                                                            AppFontSize.little),
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: widget.creditCardList.length - 1 == index
                                ? 16
                                : 0),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      );
    } else if (widget.loading) {
      const int item = 3;
      return Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.white,
        ),
        child: Column(
          children: [
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox();
                  },
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: item,
                  itemBuilder: (context, index) {
                    return Skeletonizer(
                      enabled: true,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppTheme.white,
                              AppTheme.lightBlue10,
                            ],
                          ),
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
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 70,
                                    child: Bone.square(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Bone.text(words: 2),
                                      const SizedBox(height: 8),
                                      Bone.text(words: 2),
                                    ],
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
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageAsset.img_default_empty,
              width: 150,
              height: 150,
            ),
            TextLabel(
              text: translate('empty.card'),
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.superlarge),
              color: AppTheme.black40,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      );
    }
  }
}
