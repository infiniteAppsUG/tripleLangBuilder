## infiniteApps' tripleLangBuilder for Flutter

This builder helps you to create several translations for your Flutter project at once. This is necessary if you want to publish your Flutter app in different markets with their respective languages, e.g. Spanish in Spain and Latin America.

## How should you proceed?
 1. In your Flutter project add e.g. the 'intl' package and follow all the instructions. 
 2. After correct initialization, you should have different files, e.g. 
	 2.1. app_en.arb
	 2.2. app_de.arb
	 2.3. app_es.arb
3. Copy the three files in the root directory of tripleLangBuilder (you should backup them first, just in case)
4. If you don't have it yet, create an API-Key at DeepL.com or implement another translation API of your choice.
5. Add your API-key to the api_key.dart in 'const' folder in the tripleLangBuilder project folder
6. Open terminal go to the root directory of tripleLangBuilder and type: `dart main.dart`
7. Follow the steps in the terminal window and create three language files at once
8. Copy the created .arb-files back to your Flutter project
9. Now you can re-compile your Flutter project and access the recently created translation keys :)
10. Alternatively you can add the project to your Flutter project itself so you don't need to copy and paste the files.

 ## What else?
 At the moment the tool takes `app_en.arb` as the *mainFile* and creates the necessary structure in that document. German and Spanish will be created as translation. In further version I will introduce a way to create more translations by only passing the language codes as parameters. If you want to create different languages you just need to modify the language codes in the code (verify that the translation API supports them). 
 Error handling is not very sophisticated yet 
 