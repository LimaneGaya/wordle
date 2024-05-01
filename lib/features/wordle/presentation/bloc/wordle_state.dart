part of 'wordle_bloc.dart';

abstract class WordleState {
  final List<Word> guessedWords;
  final Word wantedWord;
  final int index;

  WordleState(
      {required this.guessedWords,
      required this.index,
      required this.wantedWord});

  @override
  operator ==(covariant WordleState other) {
    return guessedWords == other.guessedWords &&
        index == other.index &&
        wantedWord == other.wantedWord;
  }

  @override
  int get hashCode =>
      guessedWords.hashCode + index.hashCode + wantedWord.hashCode;
}

class WordlePlaying extends WordleState {
  WordlePlaying(
      {required super.guessedWords,
      required super.index,
      required super.wantedWord});
}

class WordleWon extends WordleState {
  WordleWon(
      {required super.guessedWords,
      required super.index,
      required super.wantedWord});
}

class WordleLost extends WordleState {
  WordleLost(
      {required super.guessedWords,
      required super.index,
      required super.wantedWord});
}
