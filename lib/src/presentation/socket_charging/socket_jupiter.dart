import 'dart:async';
// import 'package:flutter/material.dart';
import 'package:jupiter_api/data/data_models/response/charging_socket/charging_info_model.dart';
import 'package:jupiter_api/data/data_models/response/charging_socket/realtime_status_checkin_model.dart';
// import 'package:socket_io_client/socket_io_client.dart';
// import '../../config/api/api_config.dart';

class SocketJupiter {
  /// The [qrCodeData] is qrCode Subscript Charger
  SocketJupiter({required this.qrCodeData});
  final String qrCodeData;
  // StreamSocket streamSocket = StreamSocket();
  // void connectAndListen(String accessToken) async {
  //   Socket socket = io(
  //       '${ApiConfig.domain}/information-realtime-charging/',
  //       OptionBuilder()
  //           .setQuery({"token": accessToken})
  //           .setTransports(['websocket'])
  //           .setPath('/information-realtime-charging/')
  //           .build());

  //   socket.onConnect((_) {
  //     debugPrint('connect');
  //   });
  //   socket.on(
  //       qrCodeData,
  //       (data) => {
  //             debugPrint("EventData ${data}"),
  //             streamSocket.addResponse(ChargingInfoModel.fromJson(data)),
  //           });
  //   socket.onConnectError((data) => {
  //         debugPrint("connectError $data"),
  //       });
  //   socket.onError((data) => debugPrint("onError $data"));
  //   socket.onDisconnect((_) => debugPrint('disconnect'));
  // }
}

class StreamSocket {
  final _socketResponse = StreamController<ChargingInfoModel>();
  void Function(ChargingInfoModel) get addResponse => _socketResponse.sink.add;
  Stream<ChargingInfoModel> get getResponse => _socketResponse.stream;
  void dispose() {
    _socketResponse.close();
  }
}

class StreamSocketStatus {
  final _socketResponse = StreamController<RealtimeStatusCheckinModel>();
  void Function(RealtimeStatusCheckinModel) get addResponse =>
      _socketResponse.sink.add;
  Stream<RealtimeStatusCheckinModel> get getResponse => _socketResponse.stream;
  void dispose() {
    _socketResponse.close();
  }
}
