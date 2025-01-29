import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'custom_image_picker_platform_interface.dart';

/// An implementation of [CustomImagePickerPlatform] that uses method channels.
class MethodChannelCustomImagePicker extends CustomImagePickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('custom_image_picker');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getID() async {
    final id = await methodChannel.invokeMethod<String>('getID');
    return id;
  }
}
