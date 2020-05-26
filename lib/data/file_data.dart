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
      final csvList = await openFile.transform(utf8.decoder).transform(new CsvToListConverter(shouldParseNumbers: false)).toList();
      final List<FlashcardModel> fcList = [];

      csvList.forEach((model) {
        fcList.add(FlashcardModel(
          model[0], model[1], model[2]
          , model[3], model[4], model[5]
          , model[6]
        ));
      });

      return fcList;
    } catch (e) {
      return [];
    }
  }

  FileData();

  //change to append after able to add flashcards
  void _writeToFile(List<List<String>> lines, {bool overwrite = false}) async {
    final file = await _file;
    String csvLines = const ListToCsvConverter().convert(lines);
    file.writeAsString(csvLines, mode: overwrite ? FileMode.writeOnly : FileMode.writeOnlyAppend);
  }

  @override
  Future<bool> addFlashcard(FlashcardModel model) async {
    try {
      model.id = await _fetchNextId();
      final csvList = model.toListString();
      _writeToFile([csvList], overwrite: true);
    } catch (e) {
      return false;
    }

    return true;
  }
  //should use writeOnlyAppend to write to end of file and not overwrite it
  @override
  Future<bool> addFlashcards(List<FlashcardModel> models) async {
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
  Future<FlashcardModel> fetchFlashcard(String name) async {
    try {
      final models = await _fileList;
      return models.first;
      //return models.firstWhere((model) => model.question == name);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<FlashcardModel>> fetchFlashcards() async {
    try {
      final models = await _fileList;
      return models;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> updateFlashcard(String name, 
    {bool right = false, bool wrong = false, bool liked = false}) async {
    try {
      final target = await fetchFlashcard("");
      
      if(right == true) target.right++;
      if(wrong == true) target.wrong++;
      if(liked == true) target.isLiked = !target.isLiked;
      
      _writeToFile([target.toListString()], overwrite: true);
      return true;

    } catch (_) {
      return false;
    }
  }

  Future<int> _fetchNextId() async {
    final fileList = await _fileList;

    return fileList.length;
  }
}