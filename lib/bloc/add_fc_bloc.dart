import 'package:flashcards/bloc/event/add_fc_event.dart';
import 'package:flashcards/bloc/state/add_fc_state.dart';
import 'package:flashcards/model/flashcard_model.dart';
import 'package:flashcards/service/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class AddFlashcardBloc extends Bloc<AddFlashcardEvent, AddFlashcardState> {
  final Repository repo;
  
  AddFlashcardBloc({@required this.repo});
  
  void onAdd(String question, String answer, String hint) {
    add(AddEvent(question: question, answer: answer, hint: hint));
  }

  @override
  AddFlashcardState get initialState => UninitialisedState();

  @override
  Stream<AddFlashcardState> mapEventToState(AddFlashcardEvent event) async* {
    if(event is AddEvent) {
      yield AddingState();
      
      FlashcardModel newFlashcard;
      bool isAdded;

      try {
        if(event.question != null && event.answer != null)
          newFlashcard = FlashcardModel
            .newModel(event.question, event.answer, event.hint);
        else
          yield _fetchErrorState(event);

        isAdded = await repo.addFlashcard(newFlashcard);

        yield AddedState(isSucc: isAdded);

      } catch(_) {
        yield ErrorState(
          question: Validator.INVALID,
          answer: Validator.INVALID,
          hint: Validator.INVALID
        );
      }
    } 
  }

  ErrorState _fetchErrorState(AddEvent event) {
    return ErrorState(
      question: event.question.isEmpty ? Validator.EMPTY : Validator.SUCCESS,
      answer: event.answer.isEmpty ? Validator.EMPTY : Validator.SUCCESS,
    );
  }
  
}