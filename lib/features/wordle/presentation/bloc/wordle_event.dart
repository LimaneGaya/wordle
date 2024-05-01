part of 'wordle_bloc.dart';

abstract class WordleEvent extends Equatable {
  const WordleEvent();

  @override
  List<Object> get props => [];
}

class WordleAddLetter extends WordleEvent {
  final String letter;
  const WordleAddLetter(this.letter);
}

class WordleDeleteLetter extends WordleEvent {}

class WordleSubmit extends WordleEvent {}
