import 'package:flutter/material.dart';
import 'package:flutter_translator/flutter_translator.dart';

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
    _translator.init(
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
          title: Text(_translator
              .getString(AppLocale.title))), // or AppLocale.title.getString()
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
                const SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    child: const Text('ភាសាខ្មែរ'),
                    onPressed: () {
                      _translator.translate('km');
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    child: const Text('日本語'),
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

mixin AppLocale {
  static const String title = 'title';

  static const Map<String, dynamic> EN = {title: 'Localization'};
  static const Map<String, dynamic> KM = {title: 'ការធ្វើមូលដ្ឋានីយកម្ម'};
  static const Map<String, dynamic> JA = {title: 'ローカリゼーション'};
}
