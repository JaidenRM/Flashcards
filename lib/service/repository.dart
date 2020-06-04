import 'package:flashcards/model/flashcard_model.dart';

import '../data/data_interface.dart';
import './data_factory.dart';

///Used to decide on the storage source and retrieval of information from it
class Repository {
  DataRetrieval data = new DataFactory().create();

  //decide on how bloc calls this and assign the correct data func
  Future<FlashcardModel> fetchFlashcard(int id, { bool isNext = false, bool isPrev = false }) async => 
    await data.fetchFlashcard(id);
  Future<List<FlashcardModel>> fetchFlashcards() async => await data.fetchFlashcards();
  Future<bool> addFlashcard(FlashcardModel flashcard) async => await data.addFlashcard(flashcard);
  Future<bool> addFlashcards(List<FlashcardModel> flashcards) async => await data.addFlashcards(flashcards);
  Future<bool> updateFlashcards(int id, {bool right, bool wrong, bool liked})
    async => await data.updateFlashcard(id, right: right, wrong: wrong, liked: liked);
}