part of 'wordle_bloc.dart';

abstract class WordleState {
  final List<Word> guessedWords;
  final Word wantedWord;
  final int index;

  WordleState(
      {required this.guessedWords, this.index = 0, required this.wantedWord});

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
  WordlePlaying.initial()
      : super(
            guessedWords: generateNewWord(height: 6, width: 5),
            wantedWord: Word.fromString(WordList.getWord()));
  Set<Letter> keyboardState() {
    return Set<Letter>.from(
      guessedWords.reversed.expand((e) => e.word),
    )..remove(Letter.initial());
  }
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
