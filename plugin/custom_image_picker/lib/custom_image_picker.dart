import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'custom_image_picker_platform_interface.dart';

class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker({super.key});

  Future<String?> getPlatformVersion() {
    return CustomImagePickerPlatform.instance.getPlatformVersion();
  }

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const AndroidView(
          viewType: 'custom_image_picker/flutter_picker',
        );
      case TargetPlatform.iOS:
        return const UiKitView(
          viewType: 'custom_image_picker/flutter_picker',
        );
      default:
        return Text(
            '$defaultTargetPlatform is not yet supported by the web_view plugin');
    }
  }
}
