import 'web_view_custom_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef FlutterWebViewCreatedCallback = void Function(
    WebViewController controller);

class WebViewCustom extends StatelessWidget {
  final FlutterWebViewCreatedCallback onMapViewCreated;
  const WebViewCustom({Key? key, required this.onMapViewCreated})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: 'web_view_custom/flutter_web_view',
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: 'web_view_custom/flutter_web_view',
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      default:
        return Text(
            '$defaultTargetPlatform is not yet supported by the web_view plugin');
    }
  }

  // Callback method when platform view is created
  void _onPlatformViewCreated(int id) =>
      onMapViewCreated(WebViewController._(id));

  Future<String?> getPlatformVersion() {
    return WebViewCustomPlatform.instance.getPlatformVersion();
  }
}

// WebView Controller class to set url etc
class WebViewController {
  WebViewController._(int id)
      : _channel = MethodChannel('web_view_custom/flutter_web_view_$id');

  final MethodChannel _channel;

  Future<void> setUrl({required String url}) async {
    return _channel.invokeMethod('setUrl', url);
  }

  Future<void> setNewUrl({required String url}) async {
    return _channel.invokeMethod('setNewUrl', url);
  }

  Future<dynamic> getToken() async {
    return _channel.invokeMethod('getToken');
  }
}
