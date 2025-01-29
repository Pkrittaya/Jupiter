import 'dart:io';

import 'package:custom_image_picker/custom_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:jupiter/src/apptheme.dart';
import 'package:photo_manager/photo_manager.dart';

class PickerImageForLimited extends StatefulWidget {
  const PickerImageForLimited({super.key});

  @override
  State<PickerImageForLimited> createState() => _PickerImageState();
}

class _PickerImageState extends State<PickerImageForLimited> {
  final _customImagePickerPlugin = CustomImagePicker();
  final eventChannel = EventChannel('PickerHandler');

  Stream<String> streamTimeFromNative() {
    return eventChannel
        .receiveBroadcastStream()
        .map((event) => event.toString());
  }

  File? imageFile;
  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen((event) {
      debugPrint("event  $event");
    });
  }

  Future<void> getImageFromId(String? id) async {
    final AssetEntity? asset = await AssetEntity.fromId(id ?? '');
    debugPrint("PhotosPaths Asset ${asset}");
    imageFile = await asset?.loadFile();
    Navigator.pop(context, imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        leading: Center(
            child: TextButton(
          child: Text(
            translate("button.cancel"),
            style: TextStyle(color: AppTheme.blueDark, fontSize: 18),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            StreamBuilder<String>(
              stream: streamTimeFromNative(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != "") {
                    getImageFromId(snapshot.data);
                    // imageId = snapshot.data;
                  }
                  return SizedBox();
                } else {
                  return SizedBox();
                }
              },
            ),
            Expanded(child: _customImagePickerPlugin),
            Expanded(child: Container(color: AppTheme.white))
          ],
        ),
      ),
    );
  }
}
