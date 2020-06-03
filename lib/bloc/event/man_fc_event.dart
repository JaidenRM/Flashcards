
import 'package:flashcards/bloc/state/man_fc_state.dart';

abstract class ManageFlashcardEvent {  
  int currId;

  ManageFlashcardEvent({this.currId});
}

class FetchFlashcardEvent extends ManageFlashcardEvent {
  final bool isNext, isPrev;
  final int targetId;

  FetchFlashcardEvent({ this.targetId, this.isNext, this.isPrev });
}

class ChangeFlashcardEvent extends ManageFlashcardEvent {
  final FetchedFlashcardsState state;

  ChangeFlashcardEvent(this.state);
}