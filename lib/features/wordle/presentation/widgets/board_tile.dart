import 'package:flutter/material.dart';
import 'package:wordle/core/entities/letter.dart';

class BoardTile extends StatelessWidget {
  final Letter letter;
  const BoardTile(this.letter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      alignment: Alignment.center,
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: letter.backgroundColor,
        border: Border.all(color: letter.borderColor),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          letter.letter,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
