abstract class UpdateFlashcardState {}

class UninitialisedState extends UpdateFlashcardState {}

class UpdatingFlashcardState extends UpdateFlashcardState {}

class UpdatedFlashcardState extends UpdateFlashcardState {
  final int cardId;

  UpdatedFlashcardState(this.cardId);
}

class ErrorState extends UpdateFlashcardState {}