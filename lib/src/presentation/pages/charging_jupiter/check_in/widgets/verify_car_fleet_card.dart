import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/images_asset.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/src/utilities.dart';

class VerifyCarFleetCard extends StatefulWidget {
  const VerifyCarFleetCard({
    Key? key,
    required this.onTap,
    required this.status,
    required this.isUseOcr,
    required this.licensePlate,
  }) : super(key: key);

  final Function() onTap;
  final bool status;
  final bool isUseOcr;
  final String licensePlate;
  @override
  _VerifyCarFleetCardState createState() => _VerifyCarFleetCardState();
}

class _VerifyCarFleetCardState extends State<VerifyCarFleetCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        TextLabel(
          text: translate('check_in_page.verify_ocr.text_title'),
          fontSize:
              Utilities.sizeFontWithDesityForDisplay(context, AppFontSize.big),
          fontWeight: FontWeight.bold,
          color: AppTheme.blueDark,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Container(
                child: widget.isUseOcr
                    ? !widget.status
                        ? Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppTheme.red,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextLabel(
                                  text: '${widget.licensePlate}',
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.large),
                                  color: AppTheme.red,
                                  textAlign: TextAlign.left,
                                  // fontWeight: FontWeight.bold,
                                ),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: AppTheme.red,
                                    borderRadius: BorderRadius.circular(200),
                                  ),
                                  child: Center(
                                      child: Icon(
                                    Icons.close,
                                    color: AppTheme.white,
                                    size: 20,
                                  )),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppTheme.green,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextLabel(
                                  text: '${widget.licensePlate}',
                                  fontSize:
                                      Utilities.sizeFontWithDesityForDisplay(
                                          context, AppFontSize.large),
                                  color: AppTheme.green,
                                  textAlign: TextAlign.left,
                                  // fontWeight: FontWeight.bold,
                                ),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: AppTheme.green,
                                    borderRadius: BorderRadius.circular(200),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      ImageAsset.ic_correct_password,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                    : Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppTheme.black5.withOpacity(0.5),
                          border: Border.all(
                            color: AppTheme.borderGray,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextLabel(
                              text: translate(
                                  'check_in_page.verify_ocr.field_des'),
                              fontSize: Utilities.sizeFontWithDesityForDisplay(
                                  context, AppFontSize.large),
                              color: AppTheme.gray9CA3AF,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 50,
              height: 50,
              child: Material(
                borderRadius: BorderRadius.circular(12),
                color: AppTheme.blueD,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: widget.onTap,
                  child: Center(
                    child: SvgPicture.asset(
                      ImageAsset.ic_scan_qr,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        !(widget.isUseOcr && widget.status)
            ? Container(
                margin: EdgeInsets.only(top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: !widget.isUseOcr ? AppTheme.black40 : AppTheme.red,
                      size: 12,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextLabel(
                        maxLines: 2,
                        textDecoration: TextDecoration.none,
                        fontStyle: FontStyle.normal,
                        text: !widget.isUseOcr
                            ? translate('check_in_page.verify_ocr.info_des')
                            : translate(
                                'check_in_page.verify_ocr.info_err_des'),
                        fontSize: Utilities.sizeFontWithDesityForDisplay(
                            context, AppFontSize.normal),
                        fontWeight: FontWeight.w400,
                        color:
                            !widget.isUseOcr ? AppTheme.black40 : AppTheme.red,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
