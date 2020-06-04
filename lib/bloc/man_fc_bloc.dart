import 'dart:async';
import 'dart:math';
import 'package:flashcards/bloc/state/update_fc_state.dart' as updateState;
import 'package:flashcards/bloc/update_fc_bloc.dart';
import '../model/flashcard_model.dart';
import '../service/repository.dart';
import './event/man_fc_event.dart';
import './state/man_fc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageFlashcardBloc extends Bloc<ManageFlashcardEvent, ManageFlashcardState> {
  final Repository _repo;
  final UpdateFlashcardBloc _updateBloc;
  StreamSubscription _updateSubscriber;

  ManageFlashcardBloc(this._repo, this._updateBloc) {
    _updateSubscriber = _updateBloc.listen((state) {
      if(state is updateState.UpdatedFlashcardState) 
        onFetch(id: state.cardId);
    });
  }
  
  void onFetch({int id}) {
    add(FetchFlashcardEvent(targetId: id));
  }

  void onChangeCard(bool isNext) {
    if(this.state is FetchedFlashcardsState)
      add(ChangeFlashcardEvent(state, isNext));
  }

  @override
  ManageFlashcardState get initialState => UninitialisedState();

  @override
  Stream<ManageFlashcardState> mapEventToState(ManageFlashcardEvent event) async* {
    
    if(event is FetchFlashcardEvent) {
      yield FetchingFlashcardsState();
      List<FlashcardModel> flashcards = [];

      try {
        if(event.targetId == null)
          flashcards= await _repo.fetchFlashcards();
        else
          flashcards.add(await _repo.fetchFlashcard(event.targetId));
        
        if(flashcards.length == 0) yield EmptyState();
        else yield FetchedFlashcardsState(flashcards);

      } catch(_) {
        yield ErrorState();
      }
    } else if (event is ChangeFlashcardEvent) {
      int targetId = event.isNext ? 
        min(event.state.currId + 1, event.state.flashcards.length - 1) 
        : 
        max(event.state.currId - 1, 0);

      yield FetchedFlashcardsState(event.state.flashcards, currId: targetId);
    }
  }

  @override
  Future<void> close() {
    _updateSubscriber.cancel();
    return super.close();
  }
}