import 'package:flashcards/bloc/state/update_fc_state.dart';
import 'package:flashcards/service/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'event/update_fc_event.dart';

class UpdateFlashcardBloc extends Bloc<UpdateEvent, UpdateFlashcardState> {
  final Repository _repo;

  UpdateFlashcardBloc(this._repo);

  @override
  UpdateFlashcardState get initialState => UninitialisedState();

  void onRight(int id) => add(UpdateFlashcardEvent(id, updateRight: true, updateWrong: false, updateLiked: false));

  void onWrong(int id) => add(UpdateFlashcardEvent(id, updateRight: false, updateWrong: true, updateLiked: false));

  void onLiked(int id) => add(UpdateFlashcardEvent(id, updateRight: false, updateWrong: false, updateLiked: true));

  @override
  Stream<UpdateFlashcardState> mapEventToState(UpdateEvent event) async* {
    if(event is UpdateFlashcardEvent) {
      yield UpdatingFlashcardState();

      //do foo
      final isUpdated = await _repo.updateFlashcards(event.cardId
        , right: event.updateRight
        , wrong: event.updateWrong
        , liked: event.updateLiked
      );

      yield UpdatedFlashcardState(event.cardId);
    }
  }
  
}