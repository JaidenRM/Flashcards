import '../../model/flashcard_model.dart';

class ManageFlashcardState {
  final List<FlashcardModel> addList;
  final List<FlashcardModel> fetchedList;
  final String filter;

  const ManageFlashcardState({this.addList, this.fetchedList, this.filter});

  factory ManageFlashcardState.initial() => ManageFlashcardState(addList: null, fetchedList: null, filter: null);
}