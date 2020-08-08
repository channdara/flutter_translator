import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translator/translator.dart';
import 'package:flutter_translator/translator_delegate.dart';

typedef TranslatorCallback = void Function(Locale);

class TranslatorGenerator {
  TranslatorGenerator._singleton() {
    _delegate = TranslatorDelegate(null);
  }

  static final TranslatorGenerator instance = TranslatorGenerator._singleton();

  TranslatorDelegate _delegate;
  List<String> languageCodes = const [];
  TranslatorCallback onTranslatedLanguage;

  void init({
    @required List<String> languageCodes,
    @required String initLanguageCode,
  }) {
    this.languageCodes = languageCodes;
    this._delegate = TranslatorDelegate(Locale(initLanguageCode ?? 'en'));
  }

  void translate(String languageCode) {
    onTranslatedLanguage(Locale(languageCode));
  }

  void reloadDelegate(Locale locale) {
    _delegate = TranslatorDelegate(locale);
  }

  String getString(BuildContext context, String key) =>
      Translator.of(context).getString(key);

  Iterable<Locale> get supportedLocales =>
      languageCodes.map<Locale>((language) => Locale(language));

  Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        _delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];
}
