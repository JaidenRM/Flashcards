import 'package:equatable/equatable.dart';
import '../../model/flashcard_model.dart';

abstract class ManageFlashcardState extends Equatable { 
  @override
  List<Object> get props => [];
}

class UninitialisedState extends ManageFlashcardState{}

class FetchingFlashcardsState extends ManageFlashcardState{}

class FetchedFlashcardsState extends ManageFlashcardState {
  final List<FlashcardModel> flashcards;
  final int currId;
  
  @override
  List<Object> get props => [flashcards, currId];
  
  FetchedFlashcardsState(this.flashcards, { this.currId = 0 });
}

class ErrorState extends ManageFlashcardState {}

class EmptyState extends ManageFlashcardState {}