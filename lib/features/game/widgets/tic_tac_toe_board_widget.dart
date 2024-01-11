import 'package:flutter/material.dart';

class TicTacToeBoard extends StatelessWidget {
  const TicTacToeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 9,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              right: index % 3 == 2 ? BorderSide.none : const BorderSide(color: Colors.grey, width: 2),
              bottom: index < 6 ? const BorderSide(color: Colors.grey, width: 2) : BorderSide.none,
              left: BorderSide.none, // Remove the left border

              // Pra parte de cima,
              // top: BorderSide.none, // Remove the top border
              top: index < 3 ? const BorderSide(color: Colors.red, width: 2) : BorderSide.none,
            ),
          ),
          child: Center(
            child: Text(
              // can you put the index here instead?
              '$index',
              style: const TextStyle(fontSize: 24),
            ),
          ),
        );
      },
    );
  }
}
