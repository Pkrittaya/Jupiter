import 'package:flutter/cupertino.dart';

import '../../../../apptheme.dart';
import '../../../../constant_value.dart';
import '../../../../utilities.dart';
import '../../../widgets/text_label.dart';

class RowSwitch extends StatefulWidget {
  RowSwitch({
    super.key,
    required this.switchValue,
    required this.title,
    required this.onChangedValue,
    this.hasText,
    this.textLeft,
    this.textRight,
  });
  final bool switchValue;
  final String title;
  final Function(bool) onChangedValue;
  final bool? hasText;
  final String? textLeft;
  final String? textRight;

  @override
  State<RowSwitch> createState() => _RowSwitchState();
}

class _RowSwitchState extends State<RowSwitch> {
  bool _switchValue = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _switchValue = widget.switchValue;
    debugPrint("RowSwitchStartBuild $_switchValue");
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextLabel(
                text: widget.title,
                fontSize: Utilities.sizeFontWithDesityForDisplay(
                    context, AppFontSize.big),
                color: AppTheme.blueDark,
                fontWeight: FontWeight.bold,
              ),
              Container(
                width: 50,
                height: 35,
                child: widget.hasText ?? false
                    ? Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // _switchValue = !_switchValue;
                              // widget.onChangedValue(_switchValue);
                              // if (!(widget.hasText ?? false)) {
                              //   widget.onChangedValue(!_switchValue);
                              // }
                            },
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: CupertinoSwitch(
                                value: _switchValue,
                                trackColor: AppTheme.blueD,
                                activeColor: AppTheme.blueD,
                                onChanged: (value) {
                                  if (!(widget.hasText ?? false)) {
                                    debugPrint("OnChangeSwitch");

                                    _switchValue = !value;
                                    widget.onChangedValue(_switchValue);
                                  }
                                  // widget.onChangedValue(!value);
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: widget.hasText ?? false,
                            child: GestureDetector(
                              onTap: () {
                                _switchValue = !_switchValue;
                                widget.onChangedValue(_switchValue);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                color: AppTheme.transparent,
                                child: Align(
                                  alignment: _switchValue
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: TextLabel(
                                    color: AppTheme.white,
                                    text: !_switchValue
                                        ? widget.textLeft ?? 'TH'
                                        : widget.textRight ?? 'EN',
                                    fontSize:
                                        Utilities.sizeFontWithDesityForDisplay(
                                      context,
                                      AppFontSize.little,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Visibility(
                          //   visible: !(widget.hasText ?? false),
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       onChanged(!value);
                          //     },
                          //     child: Align(
                          //       alignment: Alignment.centerLeft,
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(left: 6),
                          //         child: TextLabel(
                          //           text: 'TH',
                          //           color: AppTheme.white,
                          //           fontSize:
                          //               Utilities.sizeFontWithDesityForDisplay(
                          //             context,
                          //             AppFontSize.little,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                    : FittedBox(
                        fit: BoxFit.fill,
                        child: CupertinoSwitch(
                          value: widget.switchValue,
                          activeColor: AppTheme.blueD,
                          onChanged: widget.onChangedValue,
                        ),
                      ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 12),
            height: 1,
            width: double.infinity,
            color: AppTheme.borderGray,
          )
        ],
      ),
    );
  }
}
