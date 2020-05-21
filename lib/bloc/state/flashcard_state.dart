abstract class FlashcardState {
  bool isFront = true;
}

class UninitialisedState extends FlashcardState {}

class FlippedState extends FlashcardState {
  FlippedState(bool isFront) {
    super.isFront = isFront;
  }
}

class ErrorState extends FlashcardState {}