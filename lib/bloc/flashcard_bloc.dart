import 'package:bloc/bloc.dart';
import 'package:flashcards/bloc/event/flashcard_event.dart';
import 'package:flashcards/bloc/state/flashcard_state.dart';

class FlashcardBloc extends Bloc<FlashcardEvent, FlashcardState> {
  
  void onFrontFlip() {
    add(FlipToFront());
  }

  void onBackFlip() {
    add(FlipToBack());
  }
   

  @override
  FlashcardState get initialState => FlashcardState.initial();

  @override
  Stream<FlashcardState> mapEventToState(FlashcardEvent event) async* {
    final _state = state;

    if(event is FlipToFront) {
      yield FlashcardState(isQ: true);
    } else if (event is FlipToBack) {
      yield FlashcardState(isQ: false);
    }
  }
}