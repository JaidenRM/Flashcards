import 'package:equatable/equatable.dart';

abstract class UpdateFlashcardState extends Equatable {
  
  @override
  List<Object> get props => [];
}

class UninitialisedState extends UpdateFlashcardState {}

class UpdatingFlashcardState extends UpdateFlashcardState {}

class UpdatedFlashcardState extends UpdateFlashcardState {
  final int cardId;

  UpdatedFlashcardState(this.cardId);

  @override
  List<Object> get props => [cardId];
}

class ErrorState extends UpdateFlashcardState {}