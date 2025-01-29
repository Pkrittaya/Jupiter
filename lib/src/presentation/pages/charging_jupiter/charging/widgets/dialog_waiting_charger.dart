import 'dart:async';
import 'package:jupiter/src/apptheme.dart';
import 'package:jupiter/src/constant_value.dart';
import 'package:jupiter/src/presentation/widgets/lifecycle_watcher_state.dart';
import 'package:jupiter/src/presentation/widgets/text_label.dart';
import 'package:jupiter/src/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class DialogWaitingCharger extends StatefulWidget {
  @override
  _DialogWaitingChargerState createState() => new _DialogWaitingChargerState();
}

class _DialogWaitingChargerState
    extends LifecycleWatcherState<DialogWaitingCharger> {
  // Cooldown
  int countdown = 10;
  Timer? timer;

  @override
  void initState() {
    setCooldown();
    super.initState();
  }

  @override
  void dispose() {
    try {
      timer?.cancel();
      super.dispose();
    } catch (e) {
      debugPrint('ERROR super.dispose()');
    }
  }

  @override
  void onDetached() {}

  @override
  void onPaused() {
    try {
      timer?.cancel();
      Utilities.dialogIsVisible(context);
      super.dispose();
    } catch (e) {}
  }

  @override
  void onInactive() {
    try {
      timer?.cancel();
      Utilities.dialogIsVisible(context);
      super.dispose();
    } catch (e) {}
  }

  @override
  void onResumed() {}

  void setCooldown() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countdown--;
      });
      if (countdown <= 0) {
        timer.cancel(); // ยกเลิก Timer เมื่อนับถึง 0
        Navigator.of(context).pop(); // ปิด Dialog
      }
    });
  }

  void onPressedButton() {
    try {
      timer?.cancel();
      Utilities.dialogIsVisible(context);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      actionsAlignment: MainAxisAlignment.center,
      titlePadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
      contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 0),
      actionsPadding: EdgeInsets.fromLTRB(24, 16, 24, 20),
      title: Center(
          child: Column(
        children: [
          Icon(Icons.info_outline, color: AppTheme.blueD, size: 70),
          const SizedBox(height: 12),
          TextLabel(
            text: translate('charging_page.waiting_charger.title'),
            textAlign: TextAlign.center,
            color: AppTheme.black,
            fontSize: Utilities.sizeFontWithDesityForDisplay(
                context, AppFontSize.title),
            fontWeight: FontWeight.w700,
          ),
        ],
      )),
      content: Container(
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextLabel(
              text: translate('charging_page.waiting_charger.message'),
              textAlign: TextAlign.center,
              color: AppTheme.black,
              fontSize: Utilities.sizeFontWithDesityForDisplay(
                  context, AppFontSize.normal),
            )
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: AppTheme.blueD,
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                  ),
                ),
                onPressed: onPressedButton,
                child: TextLabel(
                  text:
                      '${translate('charging_page.waiting_charger.close')} ${countdown} ${translate('charging_page.waiting_charger.min')}',
                  fontSize: Utilities.sizeFontWithDesityForDisplay(
                      context, AppFontSize.normal),
                  fontWeight: FontWeight.w700,
                  color: AppTheme.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
