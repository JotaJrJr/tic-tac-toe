import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/features/create_room/view/create_room_page.dart';
import 'package:tic_tac_toe_game/features/game/view/game_page.dart';
import 'package:tic_tac_toe_game/features/join_rooom/view/join_room_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Play with AI'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToPage(const JoinRoomPage()),
              child: const Text('Play with friend'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToPage(const CreateRoomPage()),
              child: const Text('Create a room'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToPage(const GamePage()),
              child: const Text('Board'),
            ),
          ],
        ),
      ),
    );
  }

  _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
