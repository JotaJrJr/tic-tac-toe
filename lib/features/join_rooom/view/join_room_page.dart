import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/features/join_rooom/viewmodel/join_room_view_model.dart';

import '../../../widgets/custom_text_field_widget.dart';

class JoinRoomPage extends StatefulWidget {
  const JoinRoomPage({super.key});

  @override
  State<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  late JoinRoomViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = JoinRoomViewModel();

    _viewModel.socketMethods.roomJoinedListener(context);
    _viewModel.socketMethods.errorOcurredListener(context);
    _viewModel.socketMethods.updatePlayersStateListen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 30,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Join\nRoom",
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
              labelText: "Enter your name",
              controller: _viewModel.playerNameController,
            ),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
              labelText: "Enter room ID",
              controller: _viewModel.roomIdController,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                ),
                onPressed: () {
                  if (_viewModel.canJoinRoom()) {
                    _viewModel.joinRoom();
                    // _navigateTo(const CreateRoomPage());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fields are empty'),
                      ),
                    );
                  }
                },
                child: const Text('Join'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
