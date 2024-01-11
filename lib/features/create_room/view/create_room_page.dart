import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/features/create_room/viewmodel/create_room_view_model.dart';
import 'package:tic_tac_toe_game/resources/socket_client.dart';
import 'package:tic_tac_toe_game/widgets/custom_text_field_widget.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({super.key});

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  late CreateRoomViewModel _viewModel;

  final SocketClient _socketClient = SocketClient();

  @override
  void initState() {
    super.initState();
    _viewModel = CreateRoomViewModel();

    _socketClient.connectToDatabase();

    _viewModel.socketMethods.roomCreatedListener(context);
  }

  @override
  void dispose() {
    super.dispose();

    _viewModel.playerNameController.dispose();
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
              "Create\nRoom",
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextFieldWidget(
              controller: _viewModel.playerNameController,
              labelText: "Your Name",
            ),
            const SizedBox(height: 50),
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
                  if (_viewModel.canCreateRoom()) {
                    _viewModel.createRoom();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Name is empty'),
                      ),
                    );
                  }
                },
                child: const Text('Create'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
