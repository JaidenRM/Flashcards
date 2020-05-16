class FlashcardState {
  final bool isQ; //front part of card - with the *Q*uestion

  const FlashcardState({this.isQ});

  factory FlashcardState.initial() => FlashcardState(isQ: true);
}