import 'dart:io';
import 'translator.dart' as translator;
import 'const/dialogues.dart';

///This translation builder has been created by infiniteApps UG (haftungsbeschraenkt) 2023
///We use DeepL API in this tool because we like it but WE ARE NOT anyhow related to DeepL.
///Please feel free to implement another awesome translation API in this tool.
///This tool shall help you creating translations for Flutter Applications in a fast and uncomplicated manner
///Visit infiniteapps.de or contact us at hello@infiniteapps.de for suggestions or remarks.
///We'd love to hear from you!

void main() async {
  //Ask user for the key
  print(hintKeyInputText);
  String? keyInputText = stdin.readLineSync();

  //Ask user for the text to be translated
  print(hintSourceInputText);
  String? sourceInputText = stdin.readLineSync();

  //Ask user for the description field value
  print(hintDescriptionInputText);
  String? descriptionInputText = stdin.readLineSync();

  //Check that none of the input fields is empty
  if (sourceInputText != "" &&
      descriptionInputText != "" &&
      keyInputText != "") {
    //Format strings in the right format for the .arb file
    String keyText = keyInputText!.replaceAll(" ", "_");
    String descriptionText = descriptionInputText!.replaceAll(" ", "_");

    translator.translateText(keyText.trim(), sourceInputText!.trim(),
        descriptionText.trim(), ["DE", "ES"]);
  }
  //If one of the inputs is empty, programm will be terminated
  else {
    print("Aborted");
  }
}
