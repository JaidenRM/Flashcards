import '../model/flashcard_model.dart';

abstract class DataRetrieval {
  ///Fetchs the specified flashcard from storage based on id. The bool is used to specify
  ///whether the specific flashcard with this id should be fetched or the next flashcard after this id.
  Future<FlashcardModel> fetchFlashcard(int id) async {}
  ///Fetchs all stored flashcards
  Future<List<FlashcardModel>> fetchFlashcards() async {}
  ///Transforms the flashcard into a storable format and save it
  Future<bool> addFlashcard(FlashcardModel model) async {}
  ///Transforms the list of flashcards into a storable format and saves them
  Future<bool> addFlashcards(List<FlashcardModel> models) async {}
  ///Used to update tracked stats of the flashcard
  Future<bool> updateFlashcard(int id, {bool right, bool wrong, bool liked}) async {}
}