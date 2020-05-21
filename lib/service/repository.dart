import 'package:flashcards/model/flashcard_model.dart';

import '../data/data_interface.dart';
import './data_factory.dart';

class Repository {
  DataRetrieval data = new DataFactory().create();

  //decide on how bloc calls this and assign the correct data func
  Future<FlashcardModel> fetchFlashcard(String name) async => await data.fetchFlashcard(name);
  Future<List<FlashcardModel>> fetchFlashcards() async => await data.fetchFlashcards();
  bool addFlashcard(FlashcardModel flashcard) {}
  bool addFlashcards(List<FlashcardModel> flashcards) {}
  Future<bool> updateFlashcards(String name, {bool right, bool wrong, bool liked})
    async => await data.updateFlashcard(name, right: right, wrong: wrong, liked: liked);
}