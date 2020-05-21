import 'package:bloc/bloc.dart';
import 'package:flashcards/bloc/event/flashcard_event.dart';
import 'package:flashcards/bloc/state/flashcard_state.dart';

class FlashcardBloc extends Bloc<FlashcardEvent, FlashcardState> {
  bool _isFront = true;

  void flip() {
    add(FlipEvent());
  }
   
  @override
  FlashcardState get initialState => UninitialisedState();

  @override
  Stream<FlashcardState> mapEventToState(FlashcardEvent event) async* {
    
    if(event is FlipEvent) {
      _isFront = !_isFront;
      yield FlippedState(_isFront);
    } 
    
  }
}