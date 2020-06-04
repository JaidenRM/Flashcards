
import 'package:flashcards/bloc/state/man_fc_state.dart';

abstract class ManageFlashcardEvent {  
  int currId;

  ManageFlashcardEvent({this.currId});
}

class FetchFlashcardEvent extends ManageFlashcardEvent {
  final int targetId;

  FetchFlashcardEvent({ this.targetId });
}

class ChangeFlashcardEvent extends ManageFlashcardEvent {
  final FetchedFlashcardsState state;
  final bool isNext;

  ChangeFlashcardEvent(this.state, this.isNext);
}