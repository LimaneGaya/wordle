import 'package:flutter/material.dart';

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
                return _KeyBoardButton(
                  onTap: () => onKeyPressed(letter),
                  letter: letter,
                  backgroundColor: Colors.grey,
                );
              }).toList(),
            ),
          )
          .toList(),
    );
  }
}

class _KeyBoardButton extends StatelessWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final String letter;
  final VoidCallback onTap;
  const _KeyBoardButton({
    super.key,
    this.height = 45,
    this.width = 40,
    required this.backgroundColor,
    required this.letter,
    required this.onTap,
  });
  factory _KeyBoardButton.delete({required VoidCallback onTap}) {
    return _KeyBoardButton(
      width: 56,
      backgroundColor: Colors.grey,
      letter: 'DEL',
      onTap: onTap,
    );
  }
  factory _KeyBoardButton.enter({required VoidCallback onTap}) {
    return _KeyBoardButton(
      width: 70,
      backgroundColor: Colors.grey,
      letter: 'ENTER',
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
                onTap: onTap,
                child: Container(
                  width: width,
                  height: height,
                  alignment: Alignment.center,
                  child: Text(
                    letter,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))));
  }
}
