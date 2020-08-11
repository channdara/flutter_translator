# How to use

## Create the json file for the language translation
We're not support the dynamic path and file name yet so the json files have to be at the **assets/locales/**
and the file name has to be **localization_{languageCode}.json** example: **localization_en.json**
So the directory tree will look like this:
```
project_root_directory
|__ ...
|__ assets
    |__ fonts
    |__ images
    |__ locales
        |__ localization_en.json
        |__ localization_kh.json
        |__ localization_ja.json
|__ ...
```
And don't for get to add asset path to the pubspec.yaml:
```
assets:
    - assets/locales/
```

## Project configuration
**Initialize the TranslatorGenerator object (this can be local or global, up to you)**
```
final TranslatorGenerator _translator = TranslatorGenerator.instance;
```

**Init the supported languages and default language code for the app. This has to be done only at the main.dart**
```
@override
void initState() {
    _translator.init(
        languageCodes: ['en', 'kh', 'ja'],
        initLanguageCode: 'en',
    );
    _translator.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
}

void _onTranslatedLanguage(Locale locale) {
    setState(() {});
}
```

**Add supportedLocales and localizationsDelegates to the MaterialApp**
```
@override
Widget build(BuildContext context) {
    return MaterialApp(
        supportedLocales: _translator.supportedLocales,
        localizationsDelegates: _translator.localizationsDelegates,
        home: HomeScreen(),
    );
}
```

**Call the translate function anytime you want to translate the app and provide it with the language code**
```
RaisedButton(
    child: Text('English'),
    onPressed: () {
        _translator.translate('en');
    },
),
```

**To display the value from the json file, just use the getString function by providing context and key**
```
_translator.getString(context, 'title');
```