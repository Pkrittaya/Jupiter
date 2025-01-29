import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';
import 'package:jupiter/main.dart' as app;
import 'package:jupiter/src/widget_key.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  Future<void> loading(WidgetTester tester) async {
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
  }

  Future<void> delay(WidgetTester tester) async {
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
  }

  Future<void> login(WidgetTester tester) async {
    // INPUT USERNAME & PASSWORD
    final hasTextField = find.byKey(WidgetKey.LOGIN_TF_USERNAME);
    debugPrint('hasTextField : ${hasTextField}');
    try {
      await tester.tap(find.byKey(WidgetKey.LOGIN_TF_USERNAME));
      await tester.showKeyboard(find.byKey(WidgetKey.LOGIN_TF_USERNAME));
      await tester.enterText(
        find.byKey(WidgetKey.LOGIN_TF_USERNAME),
        'tletawan6@gmail.com',
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(WidgetKey.LOGIN_TF_PASSWORD));
      await tester.enterText(
        find.byKey(WidgetKey.LOGIN_TF_PASSWORD),
        'P@ssw0rd',
      );
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // PRESS BUTTON LOGIN
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(WidgetKey.LOGIN_BT_LOGIN));

      // CREATE PIN => CONFIRM PIN => INPUT PIN
      for (var i = 0; i < 6; i++) {
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(InkWell, '1'));
      }
      for (var i = 0; i < 6; i++) {
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(InkWell, '1'));
      }
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextLabel, 'ยกเลิก'));
      for (var i = 0; i < 6; i++) {
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(InkWell, '1'));
      }
    } catch (e) {
      await tester.pumpAndSettle();
      for (var i = 0; i < 6; i++) {
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(InkWell, '1'));
      }
    }
  }

  Future<void> goToPaymentPage(WidgetTester tester) async {
    // CREATE PIN => CONFIRM PIN => INPUT PIN
    try {
      await tester.tap(find.widgetWithText(InkWell, 'การชำระเงิน'));
    } catch (e) {
      await tester.tap(find.widgetWithText(InkWell, 'Payment'));
    }
  }

  Future<void> onTapGoBackIconButton(WidgetTester tester) async {
    // GO BACK PAGE
    await delay(tester);
    await tester.tap(find.byKey(WidgetKey.BT_BACK_PAGE));
    await delay(tester);
  }

  testWidgets(
    'Open App => Login => Go to Home Page',
    (WidgetTester tester) async {
      // OPEN APP
      app.main();

      // CHECK LOGIN OR NOT LOGIN
      await loading(tester);
      await loading(tester);
      await login(tester);

      // DELAY LOADING API
      await loading(tester);

      // GO TO PAYMENT PAGE
      // await goToPaymentPage(tester);
      // await delay(tester);
      // await onTapGoBackIconButton(tester);

      // END PROCESS
      expect(find.widgetWithText(TextLabel, 'ข่าวสาร'), findsOneWidget);
    },
  );
}
