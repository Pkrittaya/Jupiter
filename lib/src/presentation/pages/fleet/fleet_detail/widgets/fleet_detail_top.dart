import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/image_network_jupiter.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FleetDetailTop extends StatefulWidget {
  const FleetDetailTop({
    Key? key,
    required this.fleetType,
    required this.onPressedWidget,
    required this.loading,
    required this.image,
    required this.textDisplay,
    required this.textCar,
    required this.max,
    required this.usage,
    required this.totalEnergy,
    required this.billDate,
  }) : super(key: key);

  final String fleetType;
  final Function() onPressedWidget;
  final bool loading;
  final String image;
  final String textDisplay;
  final String textCar;
  final double max;
  final double usage;
  final double totalEnergy;
  final String billDate;

  @override
  _FleetDetailTopState createState() => _FleetDetailTopState();
}

class _FleetDetailTopState extends State<FleetDetailTop> {
  double sizeImageFleet = 99;
  double horizontal = 32;
  double widthText = 0.54;
  bool showMoreText = false;

  @override
  void initState() {
    super.initState();
  }

  Color getColorTextAvailable(double available) {
    try {
      if (available >= 0) {
        return AppTheme.black;
      } else {
        return AppTheme.red;
      }
    } catch (e) {
      return AppTheme.red;
    }
  }

  String formatCreditCardDisplay(String display) {
    try {
      return display.substring(display.length - 4);
    } catch (e) {
      return display;
    }
  }

  String formatMoney(String numberString) {
    try {
      double number = double.tryParse(numberString.replaceAll(',', '')) ?? 0.0;
      final formatter = NumberFormat.currency(decimalDigits: 2, symbol: '');
      return formatter.format(number);
    } catch (e) {
      return '0.00';
    }
  }

  String addSpacesEvery4Characters(String input) {
    try {
      StringBuffer output = StringBuffer();
      for (int i = 0; i < input.length; i++) {
        output.write(input[i]);
        if ((i + 1) % 4 == 0 && i != input.length - 1) {
          output.write(' ');
        }
      }
      return output.toString();
    } catch (e) {
      return input;
    }
  }

  String getDateFormat(String dateForApi) {
    try {
      if (dateForApi != '') {
        DateTime dateTime = DateTime.parse(dateForApi).toLocal();
        DateFormat outputFormat = DateFormat('dd MMM yyyy');
        String outputDate = outputFormat.format(dateTime);
        return outputDate; // Output: 20 Jun 2023
      }
      return dateForApi;
    } catch (e) {
      return dateForApi;
    }
  }

  double calculatePercentUsage(BuildContext context) {
    try {
      double percent = ((widget.usage * 100 / widget.max) / 100);
      if (percent > 0 && percent <= 1) {
        return (MediaQuery.of(context).size.width - (horizontal * 2)) *
                    percent <
                12
            ? 12
            : (MediaQuery.of(context).size.width - (horizontal * 2)) * percent;
      } else if (percent < 0) {
        return 0;
      } else if (percent > 1) {
        return (MediaQuery.of(context).size.width - (horizontal * 2)) < 12
            ? 12
            : (MediaQuery.of(context).size.width - (horizontal * 2));
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  void onSwitchShowMoreText() {
    setState(() {
      showMoreText = !showMoreText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          renderRowImageCar(),
          renderDivider(16, 16),
          renderTextDetail(),
          renderDivider(16, 0),
        ],
      ),
    );
  }

  Widget renderRowImageCar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: Row(
        children: [
          renderImage(widget.image),
          Container(
            margin: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                renderRowText(),
                renderRowChipImage(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget renderVisibilityIcon() {
    return InkWell(
      onTap: onSwitchShowMoreText,
      child: showMoreText
          ? Icon(Icons.visibility_off, color: AppTheme.black40, size: 20)
          : Icon(Icons.visibility, color: AppTheme.black40, size: 20),
    );
  }

  Widget renderRowText() {
    switch (widget.fleetType) {
      case FleetType.CARD:
        return Container(
          width: MediaQuery.of(context).size.width * widthText,
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: widget.loading
              ? Skeletonizer(child: Bone.text(words: 2))
              : !showMoreText
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextLabel(
                          text: '✱✱✱✱',
                          color: AppTheme.blueDark,
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.small),
                          fontWeight: FontWeight.bold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 4),
                          child: TextLabel(
                            text:
                                ' ${formatCreditCardDisplay(widget.textDisplay)}',
                            color: AppTheme.blueDark,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.superlarge - 1),
                            fontWeight: FontWeight.bold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: renderVisibilityIcon(),
                          ),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 4),
                          child: TextLabel(
                            text:
                                '${addSpacesEvery4Characters(widget.textDisplay)}',
                            color: AppTheme.blueDark,
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.superlarge - 1),
                            fontWeight: FontWeight.bold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: renderVisibilityIcon(),
                          ),
                        )
                      ],
                    ),
        );
      case FleetType.OPERATION:
        return Container(
          width: MediaQuery.of(context).size.width * widthText,
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: !widget.loading
              ? TextLabel(
                  text: '${widget.textDisplay}',
                  color: AppTheme.blueDark,
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.superlarge - 1),
                  fontWeight: FontWeight.bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : Skeletonizer(child: Bone.text(words: 2)),
        );
      default:
        return SizedBox();
    }
  }

  Widget renderRowChipImage() {
    String text = '';
    switch (widget.fleetType) {
      case FleetType.CARD:
        text = '${widget.textCar}';
        break;
      case FleetType.OPERATION:
        text = '${widget.textCar}';
        break;
      default:
        text = 'N/A';
        break;
    }
    return widget.loading
        ? Container(
            margin: EdgeInsets.only(top: 4),
            width: 70,
            height: 24,
            child: Skeletonizer(
              child: Bone.square(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          )
        : Material(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(200),
            child: InkWell(
              borderRadius: BorderRadius.circular(200),
              onTap: widget.onPressedWidget,
              child: Container(
                // margin: const EdgeInsets.only(left: 16),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: AppTheme.grayD1D5DB),
                  child: Row(children: [
                    SvgPicture.asset(
                      ImageAsset.ic_mini_car,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 4),
                    TextLabel(
                      text: '${text}',
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.little),
                      color: AppTheme.black60,
                    ),
                    SizedBox(
                        width: widget.fleetType == FleetType.OPERATION ? 8 : 0),
                    widget.fleetType == FleetType.OPERATION
                        ? Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppTheme.blueDark,
                            size: 12,
                          )
                        : SizedBox(),
                  ]),
                ),
              ),
            ),
          );
  }

  Widget renderImage(String image) {
    return Container(
      width: sizeImageFleet,
      height: sizeImageFleet,
      padding: EdgeInsets.all(image != '' ? 0 : 8),
      decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: AppTheme.borderGray)),
      child: image != ''
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: SizedBox.fromSize(
                size: Size.fromRadius(48), // Image radius
                child: ImageNetworkJupiter(
                  url: image,
                ),
                // Image.network(
                //   image,
                // ),
              ),
            )
          : SvgPicture.asset(
              ImageAsset.logo_jupiter_color,
            ),
    );
  }

  Widget renderDivider(double top, double bottom) {
    return Container(
      width: double.infinity,
      height: 1,
      margin: EdgeInsets.only(top: top, bottom: bottom),
      color: AppTheme.borderGray,
    );
  }

  Widget renderTextDetail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextLabel(
                text: translate('fleet_page.detail.usage'),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.large),
                color: AppTheme.gray9CA3AF,
                fontWeight: FontWeight.bold,
              ),
              TextLabel(
                text: translate('fleet_page.detail.available'),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.large),
                color: AppTheme.gray9CA3AF,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              !widget.loading
                  ? Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width * 0.325,
                      child: TextLabel(
                        text: '฿${formatMoney('${widget.usage}')}',
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.large * 1.5),
                        color: AppTheme.blueD,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 4, bottom: 4),
                      width: 70,
                      height: 22,
                      child: Skeletonizer(
                        child: Bone.square(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
              !widget.loading
                  ? Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width * 0.325,
                      child: TextLabel(
                        text: '฿${formatMoney('${widget.max - widget.usage}')}',
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.normal * 1.5),
                        color: getColorTextAvailable(widget.max - widget.usage),
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 6, bottom: 4),
                      width: 70,
                      height: 20,
                      child: Skeletonizer(
                        child: Bone.square(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - (horizontal * 2),
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppTheme.grayD1D5DB,
                  ),
                ),
                !widget.loading
                    ? Container(
                        width: calculatePercentUsage(context),
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppTheme.blueLightActive,
                              AppTheme.blueD,
                            ],
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextLabel(
                  text: translate('fleet_page.detail.total_energy'),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.large),
                  color: AppTheme.gray9CA3AF,
                  fontWeight: FontWeight.bold,
                ),
                Row(
                  children: [
                    SvgPicture.asset(ImageAsset.ic_total_energy_blue_d),
                    const SizedBox(width: 4),
                    !widget.loading
                        ? TextLabel(
                            text: '${formatMoney('${widget.totalEnergy}')}',
                            fontSize: Utilities.sizeFontWithDesityForDisplay(
                                context, AppFontSize.large),
                            color: AppTheme.black,
                          )
                        : Container(
                            width: 55,
                            height: 18,
                            child: Skeletonizer(
                              child: Bone.square(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextLabel(
                  text: translate('fleet_page.detail.fleet_credit'),
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.large),
                  color: AppTheme.gray9CA3AF,
                  fontWeight: FontWeight.bold,
                ),
                !widget.loading
                    ? Container(
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width * 0.325,
                        child: TextLabel(
                          text: '฿${formatMoney('${widget.max}')}',
                          fontSize: Utilities.sizeFontWithDesityForDisplay(
                              context, AppFontSize.large),
                          color: AppTheme.black,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )
                    : Container(
                        width: 70,
                        height: 18,
                        child: Skeletonizer(
                          child: Bone.square(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextLabel(
                text: translate('fleet_page.detail.billing_date'),
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.large),
                color: AppTheme.gray9CA3AF,
                fontWeight: FontWeight.bold,
              ),
              !widget.loading
                  ? TextLabel(
                      text: getDateFormat(widget.billDate),
                      fontSize: Utilities.sizeFontWithDesityForDisplay(
                          context, AppFontSize.large),
                      color: AppTheme.black,
                    )
                  : Container(
                      width: 70,
                      height: 18,
                      child: Skeletonizer(
                        child: Bone.square(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
