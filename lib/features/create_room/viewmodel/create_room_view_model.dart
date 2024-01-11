import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/resources/socket_method.dart';

class CreateRoomViewModel {
  TextEditingController playerNameController = TextEditingController();
  final SocketMethods socketMethods = SocketMethods();

  bool canCreateRoom() {
    return playerNameController.text.isNotEmpty;
  }

  Future<void> createRoom() async {
    socketMethods.createRoom(playerNameController.text);
    debugPrint("sei lá");
  }
}
