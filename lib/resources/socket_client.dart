// import 'dart:io';

import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  late IO.Socket socket;

  SocketClient() {
    connectToDatabase();
  }

  void connectToDatabase() async {
    socket = IO.io("ws://192.168.0.111:3000", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      debugPrint("Connection established");
    });
    socket.onDisconnect((_) => debugPrint("connection Disconnection"));
    socket.onConnectError((err) => debugPrint(err));
    socket.onError((err) => debugPrint(err));
  }

  void listen(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  void emit(String event, dynamic data) {
    socket.emit(event, data);
  }
}
