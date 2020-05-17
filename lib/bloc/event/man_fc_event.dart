abstract class ManageFlashcardEvent { String filter; }

class AddFlashcard extends ManageFlashcardEvent {
  AddFlashcard(String filter) {
    this.filter = filter;
  }
}
class GetFlashcard extends ManageFlashcardEvent {
  GetFlashcard(String filter) {
    this.filter = filter;
  }
}