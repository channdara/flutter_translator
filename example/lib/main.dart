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
  final _generator = TranslatorGenerator.instance;

  @override
  void initState() {
    _generator.init(
      languageCodes: ['en', 'kh', 'ja'],
      initLanguageCode: null,
    );
    _generator.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale locale) {
    setState(() {
      _generator.reloadDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: _generator.supportedLocales,
      localizationsDelegates: _generator.localizationsDelegates,
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _generator = TranslatorGenerator.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_generator.getString(context, 'title'))),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: RaisedButton(
                  child: Text('English'),
                  onPressed: () {
                    _generator.translate('en');
                  },
                ),
              ),
              Expanded(
                child: RaisedButton(
                  child: Text('Khmer'),
                  onPressed: () {
                    _generator.translate('kh');
                  },
                ),
              ),
              Expanded(
                child: RaisedButton(
                  child: Text('Japanese'),
                  onPressed: () {
                    _generator.translate('ja');
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
