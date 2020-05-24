import 'package:bloc_test/bloc_test.dart';
import 'package:flashcards/bloc/event/man_fc_event.dart';
import 'package:flashcards/bloc/man_fc_bloc.dart';
import 'package:flashcards/bloc/state/man_fc_state.dart';
import 'package:flashcards/service/repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRepository extends MockBloc<ManageFlashcardEvent, int> implements ManageFlashcardBloc {}

void main() {
  final Repository _repo = Repository();
  
  TestWidgetsFlutterBinding.ensureInitialized();
  
  const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });

  group('blocTest', () {
    blocTest(
      'emits [] when nothing is added', 
      build: () async => ManageFlashcardBloc(repo: _repo),
      expect: []
    );
    blocTest(
      'emits [fetching, empty] when file is empty', 
      build: () async => ManageFlashcardBloc(repo: _repo),
      act: (bloc) => bloc.add(FetchFlashcardEvent()),
      expect: [
        isA<FetchingFlashcardsState>(),
        isA<EmptyState>()
      ]
    );
  });
}