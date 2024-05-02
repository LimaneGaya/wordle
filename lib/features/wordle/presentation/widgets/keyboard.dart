import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/core/entities/letter.dart';
import 'package:wordle/features/wordle/presentation/bloc/wordle_bloc.dart';

const _azerty = [
  ['a', 'z', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'],
  ['q', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm'],
  ['ENTER', 'w', 'x', 'c', 'v', 'b', 'n', 'DEL'],
];

class Keyboard extends StatelessWidget {
  const Keyboard({
    super.key,
    required this.onKeyPressed,
    required this.onEnter,
    required this.onDelete,
  });
  final void Function(String) onKeyPressed;
  final VoidCallback onEnter;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordleBloc, WordleState>(
      builder: (context, state) {
        if (state is! WordlePlaying) return const SizedBox();
        final k = state.keyboardState();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _azerty
              .map(
                (keyrow) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: keyrow.map((letter) {
                    if (letter == 'DEL') {
                      return _KeyBoardButton.delete(onTap: onDelete);
                    } else if (letter == 'ENTER') {
                      return _KeyBoardButton.enter(onTap: onEnter);
                    }
                    final l = k.any((e) => e.letter == letter)
                        ? k.firstWhere((e) => e.letter == letter)
                        : Letter(letter: letter, status: LetterStatus.key);
                    return _KeyBoardButton(
                      onTap: () => onKeyPressed(letter),
                      letter: l,
                    );
                  }).toList(),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _KeyBoardButton extends StatelessWidget {
  final double height;
  final double width;
  final Letter letter;
  final VoidCallback onTap;
  const _KeyBoardButton({
    super.key,
    this.height = 45,
    this.width = 40,
    required this.letter,
    required this.onTap,
  });
  factory _KeyBoardButton.delete({required VoidCallback onTap}) {
    return _KeyBoardButton(
      width: 56,
      letter: const Letter(letter: 'DEL', status: LetterStatus.key),
      onTap: onTap,
    );
  }
  factory _KeyBoardButton.enter({required VoidCallback onTap}) {
    return _KeyBoardButton(
      width: 70,
      letter: const Letter(letter: 'ENTER', status: LetterStatus.key),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
            color: letter.backgroundColor,
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
                onTap: onTap,
                child: Container(
                  width: width,
                  height: height,
                  alignment: Alignment.center,
                  child: Text(
                    letter.letter,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))));
  }
}
