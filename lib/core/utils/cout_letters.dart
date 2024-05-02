Map<String, int> countLetters(String word) {
  final Map<String, int> letters = {};
  for (int i = 0; i < word.length; i++) {
    letters.containsKey(word[i])
        ? letters[word[i]] = letters[word[i]]! + 1
        : letters[word[i]] = 1;
  }
  return letters;
}
