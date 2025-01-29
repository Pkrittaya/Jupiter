import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'web_view_custom_platform_interface.dart';

/// An implementation of [WebViewCustomPlatform] that uses method channels.
class MethodChannelWebViewCustom extends WebViewCustomPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('web_view_custom');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
