import 'package:meta/meta.dart';

abstract class AddFlashcardState {}

enum Validator {
  SUCCESS,
  EMPTY,
  INVALID
}

class UninitialisedState extends AddFlashcardState {}

class AddedState extends AddFlashcardState {
  final bool isSucc;

  AddedState({@required this.isSucc});
}

class AddingState extends AddFlashcardState{}

class ErrorState extends AddFlashcardState {
  final Validator question, answer, hint;

  ErrorState({ 
    this.question = Validator.SUCCESS, 
    this.answer = Validator.SUCCESS, 
    this.hint = Validator.SUCCESS 
  });
}