import 'package:flutter/material.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:flutter_translator_example/app_locale.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TranslatorGenerator _translator = TranslatorGenerator.instance;

  @override
  void initState() {
    // _translator.init(
    //   supportedLanguageCodes: ['en', 'km', 'ja'],
    //   initLanguageCode: 'km',
    // );
    _translator.initWithMap(
      mapLocales: [
        MapLocale('en', AppLocale.EN),
        MapLocale('km', AppLocale.KM),
        MapLocale('ja', AppLocale.JA),
      ],
      initLanguageCode: 'en',
    );
    _translator.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: _translator.supportedLocales,
      localizationsDelegates: _translator.localizationsDelegates,
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TranslatorGenerator _translator = TranslatorGenerator.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_translator.getString(context, AppLocale.title)),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Current language is: ${_translator.getLanguageName()}'),
            const SizedBox(height: 64.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: const Text('English'),
                    onPressed: () {
                      _translator.translate('en');
                    },
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Khmer'),
                    onPressed: () {
                      _translator.translate('km');
                    },
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Japanese'),
                    onPressed: () {
                      _translator.translate('ja', save: false);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
