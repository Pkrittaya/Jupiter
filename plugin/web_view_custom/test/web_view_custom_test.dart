import 'package:flutter_test/flutter_test.dart';
import 'package:web_view_custom/web_view_custom.dart';
import 'package:web_view_custom/web_view_custom_platform_interface.dart';
import 'package:web_view_custom/web_view_custom_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWebViewCustomPlatform
    with MockPlatformInterfaceMixin
    implements WebViewCustomPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WebViewCustomPlatform initialPlatform = WebViewCustomPlatform.instance;

  test('$MethodChannelWebViewCustom is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWebViewCustom>());
  });

  test('getPlatformVersion', () async {
    WebViewCustom webViewCustomPlugin = WebViewCustom(
      onMapViewCreated: (controller) {},
    );
    MockWebViewCustomPlatform fakePlatform = MockWebViewCustomPlatform();
    WebViewCustomPlatform.instance = fakePlatform;

    expect(await webViewCustomPlugin.getPlatformVersion(), '42');
  });
}
