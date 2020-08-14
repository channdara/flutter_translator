import 'package:flutter/material.dart';
import 'package:flutter_translator/translator_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _translator = TranslatorGenerator.instance;

  @override
  void initState() {
    _translator.init(
      languageCodes: ['en', 'kh', 'ja'],
      initLanguageCode: 'kh',
    );
    _translator.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale locale) {
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
  final _translator = TranslatorGenerator.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_translator.getString(context, 'title'))),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: RaisedButton(
                  child: Text('English'),
                  onPressed: () {
                    _translator.translate('en');
                  },
                ),
              ),
              Expanded(
                child: RaisedButton(
                  child: Text('Khmer'),
                  onPressed: () {
                    _translator.translate('kh');
                  },
                ),
              ),
              Expanded(
                child: RaisedButton(
                  child: Text('Japanese'),
                  onPressed: () {
                    _translator.translate('ja');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
