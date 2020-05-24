import '../model/flashcard_model.dart';
import '../service/repository.dart';
import './event/man_fc_event.dart';
import './state/man_fc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageFlashcardBloc extends Bloc<ManageFlashcardEvent, ManageFlashcardState> {
  final Repository repo;

  ManageFlashcardBloc({this.repo}) : assert(repo != null);
  
  void onFetch({String filter}) {
    add(FetchFlashcardEvent(filter: filter));
  }

  void onUpdate({bool isRight, bool isWrong, bool isLiked}) {
    add(UpdateStateEvent(isRight: isRight, isWrong: isWrong, isLiked: isLiked));
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
    } else if(event is UpdateStateEvent) {
      yield UpdatingStatsState();

      final isUpdated = await repo.updateFlashcards(null
      , right: event.isRight, wrong: event.isWrong, liked: event.isLiked);

      if(isUpdated) yield UpdatedStatsState();
      else yield ErrorState();

    }
  }
}