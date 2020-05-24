import 'package:meta/meta.dart';
import '../../model/flashcard_model.dart';

abstract class ManageFlashcardState { 
  List<FlashcardModel> flashcards;
  int currInd;

  ManageFlashcardState({this.currInd, this.flashcards});

  FlashcardModel get currFlashcard => flashcards[currInd];
}

class UninitialisedState extends ManageFlashcardState{}

class FetchingFlashcardsState extends ManageFlashcardState{}

class AddingFlashcardsState extends ManageFlashcardState{}

class FetchedFlashcardsState extends ManageFlashcardState {
  //List<FlashcardModel> flashcards;

  FetchedFlashcardsState({@required List<FlashcardModel> flashcards})
    :super(flashcards:flashcards);
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