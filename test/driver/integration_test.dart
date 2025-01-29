import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  // await Process.run(
  //   'adb',
  //   [
  //     'shell',
  //     'pm',
  //     'grant',
  //     'com.pttdigital.jupiter', // TODO: Update this
  //     'android.permission.ACCESS_COARSE_LOCATION'
  //   ],
  // );
  await integrationDriver();
}
