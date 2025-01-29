import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'web_view_custom_method_channel.dart';

abstract class WebViewCustomPlatform extends PlatformInterface {
  /// Constructs a WebViewCustomPlatform.
  WebViewCustomPlatform() : super(token: _token);

  static final Object _token = Object();

  static WebViewCustomPlatform _instance = MethodChannelWebViewCustom();

  /// The default instance of [WebViewCustomPlatform] to use.
  ///
  /// Defaults to [MethodChannelWebViewCustom].
  static WebViewCustomPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WebViewCustomPlatform] when
  /// they register themselves.
  static set instance(WebViewCustomPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
