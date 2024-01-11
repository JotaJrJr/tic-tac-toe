import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_game/features/game/view/game_page.dart';
import 'package:tic_tac_toe_game/resources/socket_client.dart';

import '../provider/room_data_provider.dart';

class SocketMethods {
  final _socketClient = SocketClient();

  void createRoom(String name) {
    debugPrint('createRoom: $name');
    if (name.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'name': name,
      });
    }
  }

  void joinRoom(String name, String roomId) {
    if (name.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'name': name,
        'roomId': roomId,
      });
    }
  }

  void roomCreatedListener(BuildContext context) {
    _socketClient.listen('roomCreated', (data) {
      _navigateTo(const GamePage(), context);
      Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(data);
      debugPrint('roomCreatedListener: $data');
    });
  }

  void roomJoinedListener(BuildContext context) {
    _socketClient.listen('roomJoined', (data) {
      Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(data);
      debugPrint('roomJoinedListener: $data');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GamePage()),
      );
    });
  }

  void errorOcurredListener(BuildContext context) {
    _socketClient.listen('errorOcurred', (data) {
      debugPrint('errorOcurredListener: $data');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred.'),
        ),
      );
      Navigator.pop(context);
    });
  }

  void updatePlayersStateListen(BuildContext context) {
    _socketClient.listen('updatePlayers', (playerData) {
      debugPrint('updatePlayersState: $playerData');
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayerOne(playerData[0]);
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayerTwo(playerData[1]);
    });
  }

  void _navigateTo(Widget page, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.listen('updateRoom', (data) {
      debugPrint('updateRoomListener: $data');
      Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(data);
    });
  }
}
