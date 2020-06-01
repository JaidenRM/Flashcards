abstract class UpdateEvent {}

class UpdateFlashcardEvent extends UpdateEvent {
  final int cardId;
  final bool updateRight, updateWrong, updateLiked;

  UpdateFlashcardEvent(this.cardId, { this.updateRight, this.updateWrong, this.updateLiked });
}