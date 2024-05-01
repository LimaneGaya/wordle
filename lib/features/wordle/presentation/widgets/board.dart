import 'package:flutter/material.dart';
import 'package:wordle/core/entities/word.dart';
import 'package:wordle/features/wordle/presentation/widgets/board_tile.dart';

class Board extends StatelessWidget {
  final List<Word> board;
  const Board({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: board
          .map(
            (word) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: word.word
                  .map(
                    (letter) => BoardTile(letter),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}
