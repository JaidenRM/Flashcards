import '../data/data_interface.dart';
import './data_factory.dart';

class Repository {
  DataRetrieval data = new DataFactory().create();

  //decide on how bloc calls this and assign the correct data func
  void getFlashcard(String name) {}
  void getFlashcards() {}
  bool addFlashcard() {}
  bool addFlashcards() {}
}