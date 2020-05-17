import 'package:flashcards/model/flashcard_model.dart';

import '../data/data_interface.dart';
import '../data/file_data.dart';

///Factory used to decide which data source will be used to retrieve or add data
class DataFactory {
  FileData _fileData = new FileData();

  DataRetrieval create() {
    return _fileData;
  }
}