import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/core/entities/letter.dart';
import 'package:wordle/core/entities/word.dart';

part 'wordle_event.dart';
part 'wordle_state.dart';

class WordleBloc extends Bloc<WordleEvent, WordleState> {
  WordleBloc()
      : super(WordlePlaying(
            guessedWords: List.generate(
              6,
              (index) =>
                  Word(List.generate(5, (index) => Letter.initial()).toList()),
            ).toList(),
            index: 0,
            wantedWord: Word.fromString('mouse'))) {
    on<WordleAddLetter>(_wordleAddLetter);
    on<WordleDeleteLetter>(_wordleDeleteLetter);
    on<WordleSubmit>(_wordleSubmit);
  }

  void _wordleDeleteLetter(
    WordleDeleteLetter event,
    Emitter<WordleState> emit,
  ) {
    if (state is! WordlePlaying) return;
    final st = state as WordlePlaying;
    final w = [...st.guessedWords]..[st.index].removeLetter();
    emit(WordlePlaying(
      guessedWords: w,
      index: st.index,
      wantedWord: st.wantedWord,
    ));
  }

  void _wordleAddLetter(
    WordleAddLetter event,
    Emitter<WordleState> emit,
  ) {
    if (state is! WordlePlaying) return;
    final st = state as WordlePlaying;
    final w = [...st.guessedWords]..[st.index].addLetter(event.letter);
    emit(WordlePlaying(
      guessedWords: w,
      index: st.index,
      wantedWord: st.wantedWord,
    ));
  }

  void _wordleSubmit(
    WordleSubmit event,
    Emitter<WordleState> emit,
  ) {
    if (state is! WordlePlaying) return;
    final st = state as WordlePlaying;
    if (st.guessedWords[st.index].word.contains(Letter.initial())) return;
    final submitted = st.guessedWords[st.index].word;
    final letters = countLetters(st.wantedWord.toString());
    final coloredWord = calculate(letters, st.wantedWord.toString(), submitted);
    final word = Word(coloredWord);
    final w = [...st.guessedWords]..[st.index] = word;
    if (word.toString() == st.wantedWord.toString()) {
      print('win');
      return emit(WordleWon(
          guessedWords: w, index: st.index, wantedWord: st.wantedWord));
    }
    if (st.index > 5) {
      print('lost');
      return emit(WordleLost(
          guessedWords: w, index: st.index, wantedWord: st.wantedWord));
    }
    emit(WordlePlaying(
      guessedWords: w,
      index: st.index + 1,
      wantedWord: st.wantedWord,
    ));
  }
}

Map<String, int> countLetters(String word) {
  final Map<String, int> letters = {};
  for (int i = 0; i < word.length; i++) {
    letters.containsKey(word[i])
        ? letters[word[i]] = letters[word[i]]! + 1
        : letters[word[i]] = 1;
  }
  return letters;
}

List<Letter> calculate(Map<String, int> map, String wanted, List<Letter> word) {
  for (var i = 0; i < wanted.length; i++) {
    //
    if (map.containsKey(word[i].letter) && wanted[i] == word[i].letter) {
      word[i] = Letter(letter: word[i].letter, status: LetterStatus.correct);
      map[word[i].letter] == 1
          ? map.remove(word[i].letter)
          : map[word[i].letter] = map[word[i].letter]! - 1;
      //
    } else if (map.containsKey(word[i].letter)) {
      word[i] = Letter(letter: word[i].letter, status: LetterStatus.inWord);
      map[word[i].letter] == 1
          ? map.remove(word[i].letter)
          : map[word[i].letter] = map[word[i].letter]! - 1;
      //
    } else if (!map.containsKey(word[i].letter)) {
      word[i] = Letter(letter: word[i].letter, status: LetterStatus.notInWord);
    }
  }
  return word;
}
