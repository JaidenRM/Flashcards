import '../model/flashcard_model.dart';

abstract class DataRetrieval {
  Future<FlashcardModel> fetchFlashcard(String name) async {}
  Future<List<FlashcardModel>> fetchFlashcards() async {}
  Future<bool> addFlashcard(FlashcardModel model) async {}
  Future<bool> addFlashcards(List<FlashcardModel> models) async {}
  Future<bool> updateFlashcard(String name, {bool right, bool wrong, bool liked}) async {}
}