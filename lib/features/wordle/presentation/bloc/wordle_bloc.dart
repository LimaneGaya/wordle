import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/core/data/word_list.dart';
import 'package:wordle/core/entities/letter.dart';
import 'package:wordle/core/entities/word.dart';
import 'package:wordle/core/utils/check_word.dart';
import 'package:wordle/core/utils/cout_letters.dart';
import 'package:wordle/core/utils/generate_new_words.dart';

part 'wordle_event.dart';
part 'wordle_state.dart';

class WordleBloc extends Bloc<WordleEvent, WordleState> {
  WordleBloc() : super(WordlePlaying.initial()) {
    on<WordleAddLetter>(_wordleAddLetter);
    on<WordleDeleteLetter>(_wordleDeleteLetter);
    on<WordleSubmit>(_wordleSubmit);
    on<WordleRestart>(_wordleRestart);
  }

  void _wordleRestart(
    WordleRestart event,
    Emitter<WordleState> emit,
  ) {
    emit(WordlePlaying.initial());
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
      return emit(WordleWon(
          guessedWords: w, index: st.index, wantedWord: st.wantedWord));
    }
    if (st.index >= 5) {
      return emit(WordleLost(
          guessedWords: w, index: st.index, wantedWord: st.wantedWord));
    }
    print(st.index + 1);
    emit(WordlePlaying(
      guessedWords: w,
      index: st.index + 1,
      wantedWord: st.wantedWord,
    ));
  }
}
