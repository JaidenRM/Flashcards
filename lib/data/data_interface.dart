import '../model/flashcard_model.dart';

abstract class DataRetrieval {
  Future<FlashcardModel> fetchFlashcard(String name) async {}
  Future<List<FlashcardModel>> fetchFlashcards() async {}
  bool addFlashcard(FlashcardModel model) {}
  bool addFlashcards(List<FlashcardModel> models) {}
  Future<bool> updateFlashcard(String name, {bool right, bool wrong, bool liked}) async {}
}