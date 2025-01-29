import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:custom_image_picker/custom_image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _platformVersion = 'Unknown';
  // final eventChannel = EventChannel('PickerHandler');
  @override
  void initState() {
    super.initState();
    // initPlatformState();
    // eventChannel.receiveBroadcastStream().listen((event) {
    //   debugPrint("eventMyApp  $event");
    // });
  }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   // We also handle the message potentially returning null.
  //   try {
  //     platformVersion = await _customImagePickerPlugin.getPlatformVersion() ??
  //         'Unknown platform version';
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color: Colors.amber,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text('Modal BottomSheet'),
                            Expanded(child: PickerImage()),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text("Test")),
          ],
        ),
      ),
    );
  }
}

class PickerImage extends StatefulWidget {
  const PickerImage({super.key});

  @override
  State<PickerImage> createState() => _PickerImageState();
}

class _PickerImageState extends State<PickerImage> {
  final _customImagePickerPlugin = const CustomImagePicker();
  final eventChannel = const EventChannel('PickerHandler');

  Stream<String> streamTimeFromNative() {
    return eventChannel
        .receiveBroadcastStream()
        .map((event) => event.toString());
  }

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen((event) {
      debugPrint("event  $event");
    });
  }

  String? imageId;
  Future<void> exmaple(String? id) async {
    final AssetEntity? asset = await AssetEntity.fromId(id ?? '');
    debugPrint("PhotosPaths Asset $asset");
    File? file = await asset?.loadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<String>(
          stream: streamTimeFromNative(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              exmaple(snapshot.data);
              imageId = snapshot.data;
              if (snapshot.data != "") {
                Navigator.pop(context);
              }
              return Text(
                '${snapshot.data}',
                style: Theme.of(context).textTheme.headline4,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        Expanded(child: _customImagePickerPlugin),
      ],
    );
  }
}
