import 'package:wordle/core/entities/letter.dart';

class Word {
  final List<Letter> word;
  const Word(this.word);

  factory Word.fromString(String word) =>
      Word(word.split('').map((e) => Letter(letter: e)).toList());

  Word addLetter(String val) {
    final currentIndex = word.indexWhere((e) => e.letter.isEmpty);
    if (currentIndex != -1) word[currentIndex] = Letter(letter: val);
    return Word(word);
  }

  Word removeLetter() {
    final currentIndex = word.lastIndexWhere((e) => e.letter.isNotEmpty);
    if (currentIndex != -1) word[currentIndex] = Letter.initial();
    return Word(word);
  }

  @override
  String toString() {
    return word.map((e) => e.letter).join();
  }

  @override
  bool operator ==(covariant Word other) {
    return toString() == other.toString();
  }

  @override
  int get hashCode => toString().hashCode;
}
