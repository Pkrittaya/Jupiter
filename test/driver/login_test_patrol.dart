// import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:jupiter/src/presentation/pages/login/widget/email_input.dart';
import 'package:jupiter/src/presentation/pages/login/widget/password_input.dart';
import 'package:jupiter/src/presentation/widgets/index.dart';

import 'package:jupiter/main.dart' as app;
import 'package:patrol/patrol.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  patrolTest('LoginTest', (tester) async {
    app.main();

    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    await tester(SingleChildScrollView).tap();
    // await tester.pump();
    // Tap the + icon and trigger a frame.
    // await tester.tap(find.byKey(const Key('emailIn')));
    await tester(EmailInput).enterText("tletawan6@gmail.com");
    await tester.pumpAndSettle();
    await tester(PasswordInput).enterText("P@ssw0rd");
    await tester.pumpAndSettle();

    // await tester.pumpAndSettle();
    // await tester.tap(find.byType(PasswordInput));
    // await tester.enterText(find.byType(PasswordInput), "P@ssw0rd");
    await tester.tester.testTextInput.receiveAction(TextInputAction.done);
    // await tester.pumpAndSettle();
    await tester(ElevatedButton).tap();

    await tester.pumpAndSettle();

    for (var i = 0; i < 6; i++) {
      await tester(InkWell).tester('1').tap();
      await tester.pumpAndSettle();
    }
    for (var i = 0; i < 6; i++) {
      await tester(InkWell).tester('1').tap();
      await tester.pumpAndSettle();
    }
    await tester(TextLabel).tester('ยกเลิก').tap();
    await tester.pumpAndSettle();

    for (var i = 0; i < 6; i++) {
      await tester(InkWell).tester('1').tap();
      await tester.pumpAndSettle();
    }
    await tester.native.grantPermissionWhenInUse();
    // expect(find.widgetWithText(TextLabel, 'ข่าวสาร'), findsOneWidget);
    // tester.idle();
    // await tester.pump();
    // tester.idle();
    tester.tester.idle();
  });
}
