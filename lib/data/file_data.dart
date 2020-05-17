import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flashcards/model/flashcard_model.dart';
import 'package:path_provider/path_provider.dart';

import './data_interface.dart';

class FileData implements DataRetrieval {
  Future<String> get _fileDir async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
  Future<File> get _file async {
    final filePath = await _fileDir;
    return File('$filePath/flashcards.csv');
  }
  Future<List<FlashcardModel>> get _fileList async {
    try {
      final file = await _file;
      final openFile = file.openRead();
      final csvList = await openFile.transform(utf8.decoder).transform(new CsvToListConverter()).toList();
      final fcList = [];

      csvList.forEach((model) {
        fcList.add(FlashcardModel(model[0], model[1], model[2]));
      });

      return fcList;
    } catch (e) {
      return [];
    }
  }

  FileData();

  void _writeToFile(List<List<String>> lines) async {
    String csvLines = const ListToCsvConverter().convert(lines);
    final file = await _file;
    file.writeAsString(csvLines);
  }

  @override
  bool addFlashcard(FlashcardModel model) {
    try {
      final csvList = model.toListString();
      _writeToFile([csvList]);
    } catch (e) {
      return false;
    }

    return true;
  }

  @override
  bool addFlashcards(List<FlashcardModel> models) {
    try {
      final csvList = [[]];
      models.forEach((model) { csvList.add(model.toListString()); });
      _writeToFile(csvList);
    } catch (e) {
      return false;
    }

    return true;
  }

  @override
  Future<FlashcardModel> getFlashcard(String name) async {
    try {
      final models = await _fileList;
      return models.firstWhere((model) => model.question == name);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<FlashcardModel>> getFlashcards() async {
    try {
      final models = await _fileList;
      return models;
    } catch (e) {
      return [];
    }
  }


}