import '../model/flashcard_model.dart';
import '../service/repository.dart';
import './event/man_fc_event.dart';
import './state/man_fc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageFlashcardBloc extends Bloc<ManageFlashcardEvent, ManageFlashcardState> {
  final Repository repo;

  ManageFlashcardBloc({this.repo}) : assert(repo != null);
  
  void onFetch(String filter) {
    add(FetchFlashcardEvent(filter: filter));
  }

  void onAdd(String question, String answer, String hint) {
    add(AddFlashcardEvent(question: question, answer: answer, hint: hint));
  }

  @override
  ManageFlashcardState get initialState => UninitialisedState();

  @override
  Stream<ManageFlashcardState> mapEventToState(ManageFlashcardEvent event) async* {
    
    if(event is FetchFlashcardEvent) {
      yield FetchingFlashcardsState();
      List<FlashcardModel> flashcards;

      try {
        if(event.filter == null)
          flashcards= await repo.fetchFlashcards();
        else
          flashcards = await repo.fetchFlashcards();
        
        if(flashcards.length == 0) yield EmptyState();
        else yield FetchedFlashcardsState(flashcards: flashcards);

      } catch(_) {
        yield ErrorState();
      }
    } else if(event is AddFlashcardEvent) {
      yield AddingFlashcardsState();
      FlashcardModel newFlashcard;
      bool isAdded;

      try {
        if(event.question.isNotEmpty && event.answer.isNotEmpty)
          newFlashcard = new FlashcardModel(event.question, event.answer, event.hint);

        isAdded = repo.addFlashcard(newFlashcard);

        if(newFlashcard == null) yield EmptyState();
        else yield AddedFlashcardsState(isSucc: isAdded);

      } catch(_) {
        yield ErrorState();
      }
    }
  }
}