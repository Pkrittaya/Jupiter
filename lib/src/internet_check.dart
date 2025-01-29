import 'dart:io';

import 'package:flutter/material.dart';

class InternetCheck {
  InternetCheck();
  bool isConnect = false;

  Future<bool> checkConnectInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect = true;
        debugPrint("Internet  Connected");
        return isConnect;
      } else {
        debugPrint("Internet  disConnected");
        isConnect = false;
        return isConnect;
      }
    } on SocketException catch (_) {
      debugPrint("Internet  disConnected");
      isConnect = false;
      return isConnect;
    }
  }
}
