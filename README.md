# Flutter Translator
Flutter Translator is a package use for in-app localization with json file. 
More easier and faster to implement. This package is inspired by the 
flutter_localizations itself.

# How To Use

## Create the json file for the language translation
We're not support the dynamic path and file name yet so the json files have to be at the 
**assets/locales/** and the file name has to be **localization_{languageCode}.json** 
example: **localization_en.json** So the directory tree will look like this:
```
project_root_directory
|__ ...
|__ android
|__ assets
    |__ fonts
    |__ images
    |__ locales
        |__ localization_en.json
        |__ localization_km.json
        |__ localization_ja.json
|__ ios
|__ lib
|__ ...
```
And don't for get to add asset path to the **pubspec.yaml**:
```
assets:
    - assets/locales/
```

## Project configuration
* Initialize the TranslatorGenerator object (this can be local or global, up to you)
```
final TranslatorGenerator translator = TranslatorGenerator.instance;
```

* Init the supported languages and default language code for the app. 
Using init() function if you wish to do the localization with json file 
or initWithMap() with Map<String, dynamic>. 
This has to be done only at the main.dart or the first MaterialApp in your project.
```
@override
void initState() {
    translator.init(
        supportedLanguageCodes: ['en', 'km', 'ja'],
        initLanguageCode: 'en',
    );

    /// or

    _translator.initWithMap(
        mapLocales: [
            MapLocale('en', MAP_EN),
            MapLocale('km', MAP_KM),
            MapLocale('ja', MAP_JA),
        ],
        initLanguageCode: 'en',
    );
    translator.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
}

void _onTranslatedLanguage(Locale locale) {
    setState(() {});
}
```

* Add supportedLocales and localizationsDelegates to the MaterialApp
```
@override
Widget build(BuildContext context) {
    return MaterialApp(
        supportedLocales: translator.supportedLocales,
        localizationsDelegates: translator.localizationsDelegates,
        home: HomeScreen(),
    );
}
```

* Call the translate function anytime you want to translate the app and provide it with 
the language code
```
RaisedButton(
    child: Text('English'),
    onPressed: () {
        translator.translate('en');
    },
),
```

* To display the value from the json file, just use the getString function 
by providing context and key
```
translator.getString(context, 'title');
```

* You also can get the language name too. If you don't specify the language code for the function,
it will return the language name depend on the current app locale
```
translator.getLanguageName(languageCode: 'en');  // English
translator.getLanguageName(languageCode: 'km');  // ភាសាខ្មែរ
translator.getLanguageName(languageCode: 'ja');  // 日本語

translator.getLanguageName();  // get language name depend on current app locale
```