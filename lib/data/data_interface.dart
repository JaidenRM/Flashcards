import '../model/flashcard_model.dart';

abstract class DataRetrieval {
  Future<FlashcardModel> getFlashcard(String name) async {}
  Future<List<FlashcardModel>> getFlashcards() async {}
  bool addFlashcard(FlashcardModel model) {}
  bool addFlashcards(List<FlashcardModel> models) {}
}