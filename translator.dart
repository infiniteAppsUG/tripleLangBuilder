import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'const/url.dart';
import 'const/api_key.dart';
import 'dart:io';

import 'functions.dart';

Future<Map<String, String>> translateText(
    String keyInputText,
    String sourceInputText,
    String descriptionInputText,
    List<String> targetLanguages) async {
  Map<String, String> translations = {};
  late String value;
  List<String> decodedValues = [];
  late String spanishTranslation;
  late String germanTranslation;

  for (var lang in targetLanguages) {
    var response = await http.post(
      deeplUrl,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'auth_key': API_KEY,
        'text': sourceInputText,
        'source_lang': "en",
        'target_lang': lang,
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      translations[lang] = jsonResponse['translations'][0]['text'];
    } else {
      translations[lang] = 'Error: ${response.statusCode}';
    }
  }

  for (var entry in translations.entries) {
    String key = entry.key;
    value = utf8.decode(latin1.encode(entry.value));
    decodedValues.add(value);

    print('$key: $value');
  }
  print(translations);

  //this only works for 3 languages at the moment, 1 root and 2 translations
  for (int i = 0; i < decodedValues.length; i++) {
    if (i.isOdd) {
      spanishTranslation = decodedValues.elementAt(i).toString();
    } else if (i.isEven) {
      germanTranslation = decodedValues.elementAt(i).toString();
      log(germanTranslation);
    }
  }

  //define dictionaries
  var mainArb = 'app_en.arb';
  var spanishArb = 'app_es.arb';
  var germanArb = 'app_de.arb';

  //define languageFiles for reading and writing them on disk
  var mainFile = File(mainArb);
  var spanishFile = File(spanishArb);
  var germanFile = File(germanArb);

  await checkIfFileExist([mainFile, spanishFile, germanFile]);

  //Assumption that English is the main root language for all translations in [mainFile]
  String mainContent = await mainFile.readAsString();
  String spanishContent = await spanishFile.readAsString();
  String germanContent = await germanFile.readAsString();

  //A MainFile is necessary because its structure differs slightly from the other files
  Map<String, dynamic> jsonContentMainfile = json.decode(mainContent);
  jsonContentMainfile[keyInputText] = '${sourceInputText}';
  jsonContentMainfile['@${keyInputText}'] = {
    'description': descriptionInputText
  };

  //Create translations in JSON file
  Map<String, dynamic> jsonContentSpanishFile = json.decode(spanishContent);
  jsonContentSpanishFile[keyInputText] = spanishTranslation;

  Map<String, dynamic> jsonContentGermanFile = json.decode(germanContent);
  jsonContentGermanFile[keyInputText] = germanTranslation;

  String updatedContentMainFile = json.encode(jsonContentMainfile);
  await mainFile.writeAsString(updatedContentMainFile);

  String updatedContentSpanishFile = json.encode(jsonContentSpanishFile);
  await spanishFile.writeAsString(updatedContentSpanishFile);

  String updatedContentGermanFile = json.encode(jsonContentGermanFile);
  await germanFile.writeAsString(updatedContentGermanFile);

  return translations;
}
