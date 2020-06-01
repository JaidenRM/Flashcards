
abstract class ManageFlashcardEvent {  
  int currId;

  ManageFlashcardEvent({this.currId});
}

class FetchFlashcardEvent extends ManageFlashcardEvent {
  final bool isNext, isPrev;
  final int targetId;

  FetchFlashcardEvent({ this.targetId, this.isNext, this.isPrev });
}