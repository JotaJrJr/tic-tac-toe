import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/models/player_model.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};

  PlayerModel _playerOne = PlayerModel(
    name: '',
    playerType: 'X',
    socketId: '',
    points: 0,
  );

  PlayerModel _playerTwo = PlayerModel(
    name: '',
    playerType: 'O',
    socketId: '',
    points: 0,
  );

  bool get canJoin => _roomData['canJoin'];

  Map<String, dynamic> get roomData => _roomData;

  PlayerModel get playerOne => _playerOne;

  PlayerModel get playerTwo => _playerTwo;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayerOne(Map<String, dynamic> data) {
    _playerOne = PlayerModel.fromMap(data);
    notifyListeners();
  }

  void updatePlayerTwo(Map<String, dynamic> data) {
    _playerTwo = PlayerModel.fromMap(data);
    notifyListeners();
  }
}
