import 'dart:async';
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';

class StreamTime {
  final _timeResponse = StreamController<int?>.broadcast();
  void Function(int?) get addResponse => _timeResponse.sink.add;
  Stream<int?> get getResponse => _timeResponse.stream.asBroadcastStream();
  void dispose() {
    _timeResponse.close();
  }
}

class InternetSignal {
  InternetSignal();

  StreamTime streamTime = StreamTime();
  int countPingPage = 0;
  bool isStarted = false;
  bool isPause = false;
  int seqPing = 0;

  /// Timer
  Timer pingTimer = Timer(const Duration(minutes: 3), () {});
  int pingDuration = 3;

  void startPing() {
    if (!isStarted && countPingPage > 0) {
      debugPrint('---------- START PING ----------');
      isStarted = true;
      int? responseTime;
      pingTimer =
          Timer.periodic(new Duration(seconds: pingDuration), (timer) async {
        seqPing++;
        try {
          /// ---func ping--- ///
          var ping = await Ping('google.com', count: 1).stream.first;

          /// ---response ping--- ///
          PingResponse? response = ping.response;
          // debugPrint(
          //     'response ping ${seqPing}: ${response?.time?.inMilliseconds}');

          /// ---condition response time--- ///
          if (response?.time?.inMilliseconds != null) {
            responseTime = response?.time?.inMilliseconds; // have Internet
          } else {
            responseTime = 0; // close Internet
          }
        } catch (e) {
          debugPrint('error : ${e}');
          responseTime = null; // error Internet
        }

        /// ---add time--- ///
        timePingInternet(responseTime);
      });
    }
  }

  void setPause(bool value) {
    isPause = value;
    debugPrint('isPause : ${isPause}');
  }

  /// func stop timer and stop ping ///
  void stopPing() {
    if (countPingPage <= 0 || isPause) {
      try {
        isStarted = false;
        debugPrint('---------- STOP PING ----------');
        pingTimer.cancel();
        seqPing = 0;
      } catch (e) {
        debugPrint('STOP PING ERROR : ${e}');
      }
    }
  }

  /// func set time into stream ///
  int? timePingInternet(int? time) {
    streamTime.addResponse(time);
    return time;
  }

  /// func set count page by call ping ///
  int setCountPingPage(int count) {
    countPingPage = count;
    return countPingPage;
  }
}
