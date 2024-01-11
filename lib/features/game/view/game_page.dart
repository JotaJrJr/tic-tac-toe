import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_game/provider/room_data_provider.dart';
import 'package:tic_tac_toe_game/resources/socket_method.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late String textToCopy;

  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    textToCopy = Provider.of<RoomDataProvider>(context, listen: false).roomData['_id'];
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListen(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Page'),
      ),
      // body: Text(
      //   textToCopy,
      // ),
      body: AnimatedBuilder(
          animation: RoomDataProvider(),
          builder: (_, __) {
            return roomDataProvider.roomData['canJoin']
                ? Center(child: WaitingLobbyWidget(roomId: textToCopy))
                : const SafeArea(
                    child: Column(
                    children: [ScoreBoardWidget()],
                  ));
          }),
      // body: Container(
      //     child: Column(
      //   children: [
      //     Text(roomDataProvider.roomData['roomId'] ?? 'No room id'),
      //     Text(
      //       Provider.of<RoomDataProvider>(context).roomData.toString(),
      //     ),
      //     const SizedBox(height: 20),
      //     Text(
      //       Provider.of<RoomDataProvider>(context).playerOne.name.toString(),
      //     ),
      //     const SizedBox(height: 20),
      //     Text(
      //       Provider.of<RoomDataProvider>(context).playerTwo.name ?? "",
      //     ),
      //     const SizedBox(height: 20),
      //     Text(roomDataProvider.roomData.toString()),

      //     // Text(roomDataProvider.playerOne.name),
      //     // Text(roomDataProvider.playerTwo.name),
      //     // TicTacToeBoardWidget(),
      //   ],
      // )),
      // body: WaitingLobbyWidget(roomId: roomDataProvider.roomData['roomId']),
      // body: const Center(child: WaitingLobbyWidget(roomId: '123')),
    );
  }
}

class ScoreBoardWidget extends StatelessWidget {
  const ScoreBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(roomDataProvider.playerOne.name ?? ""),
              Text(roomDataProvider.playerOne.points.toString()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(roomDataProvider.playerTwo.name ?? ""),
              Text(roomDataProvider.playerTwo.points.toString()),
            ],
          ),
        ),
      ],
    );
  }
}

class WaitingLobbyWidget extends StatefulWidget {
  final String roomId;

  const WaitingLobbyWidget({super.key, required this.roomId});

  @override
  State<WaitingLobbyWidget> createState() => _WaitingLobbyWidgetState();
}

class _WaitingLobbyWidgetState extends State<WaitingLobbyWidget> {
  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.roomId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Text copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Waiting for another player to join..."),
        const SizedBox(height: 20),
        const CircularProgressIndicator(),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: copyToClipboard,
          child: const Text('Copy Text'),
        ),
      ],
    );
  }
}
