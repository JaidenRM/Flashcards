import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flashcards/model/flashcard_model.dart';
import 'package:path_provider/path_provider.dart';
import './data_interface.dart';


///This class is used to retrieve data from a file source
class FileData implements DataRetrieval {
  ///Used to get the file directory path on the device
  Future<String> get _fileDir async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  ///Retrieves a csv file called 'flashcards', if it doesn't exist, it creates this file instead
  Future<File> get _file async {
    final filePath = await _fileDir;
    return File('$filePath/flashcards.csv');
  }

  ///Converts the file into a list of usable objects
  Future<List<FlashcardModel>> get _fileList async {
    try {
      final file = await _file;
      final openFile = file.openRead();
      final csvList = await openFile.transform(utf8.decoder).transform(new CsvToListConverter(
        shouldParseNumbers: false
      )).toList();
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
  ///Writes a csv line to the file source. It will append to the last line by default.
  void _writeToFile(List<List<dynamic>> lines, {bool overwrite = false}) async {
    var file = await _file;
    //IMPORTANT!!: WONT ADD EOL IF ONLY 1 IN LIST -- EXPERIMENT MORE WITH TEXTENDDELIM OR SMTH!
    lines.add([]);
    String csvLines = const ListToCsvConverter().convert(lines);

    await file.writeAsString(csvLines, mode: overwrite ? FileMode.writeOnly : FileMode.writeOnlyAppend);
  }

  @override
  Future<bool> addFlashcard(FlashcardModel model) async {
    try {
      model.id = await _fetchNextAvailId();
      final csvList = model.toListString();
      _writeToFile([csvList]);
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
  Future<FlashcardModel> fetchFlashcard(int id, {bool isNext = false, bool isPrev = false}) async {
    try {
      final models = await _fileList;
      id = isNext ? id + 1 : isPrev ? id - 1 : id;

      if(models.length >= id && id >= 0)
        return models[id - 1];
      else if(id < 0)
        return models.first;
      else
        return models[models.length - 1];
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
  Future<bool> updateFlashcard(int id, 
    {bool right = false, bool wrong = false, bool liked = false}) async {
    try {
      final target = await fetchFlashcard(id);
      
      if(right == true) target.right++;
      if(wrong == true) target.wrong++;
      if(liked == true) target.isLiked = !target.isLiked;
      
      _writeToFile([target.toListString()], overwrite: true);
      return true;

    } catch (_) {
      return false;
    }
  }

  ///Used to work out the next available ID to use when adding a new flashcard.
  Future<int> _fetchNextAvailId() async {
    final fileList = await _fileList;

    return fileList.length + 1;
  }
}