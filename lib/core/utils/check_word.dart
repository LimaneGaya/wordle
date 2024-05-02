import 'package:wordle/core/entities/letter.dart';

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
