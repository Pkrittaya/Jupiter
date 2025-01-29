import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:web_view_custom/web_view_custom_method_channel.dart';

void main() {
  MethodChannelWebViewCustom platform = MethodChannelWebViewCustom();
  const MethodChannel channel = MethodChannel('web_view_custom');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
