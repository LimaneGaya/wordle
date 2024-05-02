import 'package:wordle/core/entities/letter.dart';
import 'package:wordle/core/entities/word.dart';

generateNewWord({required int height, required int width}) {
  return List.generate(
    height,
    (_) => Word(
      List.generate(
        width,
        (_) => Letter.initial(),
      ).toList(),
    ),
  ).toList();
}
