import 'package:flashcards/service/repository.dart';
import './event/man_fc_event.dart';
import './state/man_fc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageFlashcardBloc extends Bloc<ManageFlashcardEvent, ManageFlashcardState> {
  void onFetch(String filter) {
    add(GetFlashcard(filter));
  }

  void onAdd(String filter) {
    add(AddFlashcard(filter));
  }

  @override
  ManageFlashcardState get initialState => ManageFlashcardState.initial();

  @override
  Stream<ManageFlashcardState> mapEventToState(ManageFlashcardEvent event) async* {
    final _state = state;
    final repo = new Repository();

    if(event is AddFlashcard) {
      yield ManageFlashcardState(
        addList: null,//repo.addFlashcard();
        fetchedList: null
      );
    } else if(event is GetFlashcard) {
      yield ManageFlashcardState(
        addList: null,
        fetchedList: null//repo.getFlashcards();
      );
    }
  }
}