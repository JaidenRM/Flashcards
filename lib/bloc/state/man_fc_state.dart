import 'package:meta/meta.dart';
import '../../model/flashcard_model.dart';

abstract class ManageFlashcardState { }

class UninitialisedState extends ManageFlashcardState{}

class FetchingFlashcardsState extends ManageFlashcardState{}

class AddingFlashcardsState extends ManageFlashcardState{}

class FetchedFlashcardsState extends ManageFlashcardState {
  final List<FlashcardModel> flashcards;

  FetchedFlashcardsState({@required this.flashcards});
}

class AddedFlashcardsState extends ManageFlashcardState {
  final bool isSucc;

  AddedFlashcardsState({@required this.isSucc});
}

class UpdatingStatsState extends ManageFlashcardState {}

class UpdatedStatsState extends ManageFlashcardState {
  final bool isRight, isWrong, isLiked;

  UpdatedStatsState({this.isRight, this.isWrong, this.isLiked});
}

class ErrorState extends ManageFlashcardState {}

class EmptyState extends ManageFlashcardState {}