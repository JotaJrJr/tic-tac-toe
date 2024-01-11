import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/resources/socket_method.dart';

class JoinRoomViewModel {
  TextEditingController playerNameController = TextEditingController();
  TextEditingController roomIdController = TextEditingController();

  SocketMethods socketMethods = SocketMethods();

  bool canJoinRoom() {
    return playerNameController.text.isNotEmpty && roomIdController.text.isNotEmpty;
  }

  void joinRoom() {
    socketMethods.joinRoom(
      playerNameController.text,
      roomIdController.text,
    );
  }
}
