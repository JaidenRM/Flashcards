import '../model/flashcard_model.dart';

abstract class DataRetrieval {
  Future<FlashcardModel> fetchFlashcard(String name) async {}
  Future<List<FlashcardModel>> fetchFlashcards() async {}
  bool addFlashcard(FlashcardModel model) {}
  bool addFlashcards(List<FlashcardModel> models) {}
}