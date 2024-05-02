import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum LetterStatus {
  initial,
  notInWord,
  inWord,
  correct,
  key,
}

class Letter extends Equatable {
  final String letter;
  final LetterStatus status;
  Color get backgroundColor {
    switch (status) {
      case LetterStatus.initial:
        return Colors.transparent;
      case LetterStatus.notInWord:
        return Colors.grey.shade800;
      case LetterStatus.inWord:
        return Colors.brown;
      case LetterStatus.correct:
        return Colors.greenAccent.shade700;
      case LetterStatus.key:
        return Colors.grey.shade500;
    }
  }

  Color get borderColor {
    return status == LetterStatus.initial ? Colors.grey : Colors.transparent;
  }

  const Letter({required this.letter, this.status = LetterStatus.initial});
  factory Letter.initial() => const Letter(letter: '');
  Letter copyWith({String? letter, LetterStatus? status}) {
    return Letter(
      letter: letter ?? this.letter,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [letter];
}
