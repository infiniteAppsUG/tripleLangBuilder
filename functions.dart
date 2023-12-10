import 'dart:convert';
import 'dart:io';

//this function checks if the .arb files already exist in the directory
//and if not, creates them during the translation process
checkIfFileExist(List<File> files) async {
  //initialize an empty map as json object
  final data = <String, dynamic>{};
  //searching for all files to be translated
  for (int i = 0; i < files.length; i++) {
    //if a file doesnt exist it will be created with an empty json object
    if (!files[i].existsSync()) {
      files[i].create();
      files[i].writeAsString(json.encode(data));
    }
  }
  print('${files.length} new files created');
  return files.length;
}
