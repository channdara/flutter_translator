# Flutter Translator
Flutter Translator is a package use for in-app localization with json file. 
More easier and faster to implement. This package is inspired by the 
flutter_localizations itself.

# How To Use

## Prepare language sources (Json file or Map data)
There are 2 ways of initializing the language source where the text display in app will load from,
one is from **Json file** and another one is from **Map data**. You will need to prepare one of
these two methods.

### 1. From Json file
We're not support the dynamic path and file name yet so the json files have to be at the 
**assets/locales/** and the file name has to be **localization_{languageCode}.json** 
for example: **localization_en.json**. So the directory tree will look similar to this:
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

### 2. From Map data
Create a dart file which will contain all the Map data of the locale language your app need.
You can change the file name, class name, and file path whatever you like for this method:
```
mixin AppLocale {
  static const String title = 'title';

  static const Map<String, dynamic> EN = {title: 'English Title From Map'};
  static const Map<String, dynamic> KM = {title: 'Khmer Title From Map'};
  static const Map<String, dynamic> JA = {title: 'Japanese Title From Map'};
}

```

## Project configuration
* Initialize the TranslatorGenerator object (this can be local or global, up to you)
```
final TranslatorGenerator translator = TranslatorGenerator.instance;
```

* Init the supported languages and default language code for the app. 
Using **init()** function if you wish to do the localization with **json file** 
or **initWithMap()** with **Map<String, dynamic>**. Only one method need to be initialize.
This has to be done only at the main.dart or the first MaterialApp in your project.
```
@override
void initState() {
    /// if you use the first method (with Json file)
    translator.init(
        supportedLanguageCodes: ['en', 'km', 'ja'],
        initLanguageCode: 'en',
    );

    /// if you use the second method (with Map data)
    _translator.initWithMap(
        mapLocales: [
            MapLocale('en', AppLocale.EN),
            MapLocale('km', AppLocale.KM),
            MapLocale('ja', AppLocale.JA),
        ],
        initLanguageCode: 'en',
    );
    translator.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
}

/// the setState function here is a must to add
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