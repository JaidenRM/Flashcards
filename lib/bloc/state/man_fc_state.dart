import 'package:meta/meta.dart';
import '../../model/flashcard_model.dart';

abstract class ManageFlashcardState { 
  List<FlashcardModel> flashcards;
  int currId;

  ManageFlashcardState({this.currId, this.flashcards});

  FlashcardModel get currFlashcard => flashcards[currId];
}

class UninitialisedState extends ManageFlashcardState{}

class FetchingFlashcardsState extends ManageFlashcardState{}

class FetchedFlashcardsState extends ManageFlashcardState {
  //List<FlashcardModel> flashcards;

  FetchedFlashcardsState({@required List<FlashcardModel> flashcards})
    :super(flashcards:flashcards);
}

class ErrorState extends ManageFlashcardState {}

class EmptyState extends ManageFlashcardState {}