import 'package:flutter/material.dart';
import 'package:flutter_translator/src/generator.dart';
import 'package:flutter_translator/src/translator.dart';

class TranslatorDelegate extends LocalizationsDelegate<Translator> {
  TranslatorDelegate(this.newLocale);

  final Locale? newLocale;

  /// The override function from LocalizationsDelegate to check the supported
  /// language provided by the app configuration
  @override
  bool isSupported(Locale locale) =>
      TranslatorGenerator.instance.supportedLanguageCodes
          .contains(locale.languageCode);

  /// The override function from LocalizationsDelegate to load the locale
  @override
  Future<Translator> load(Locale locale) =>
      Translator.load(newLocale ?? locale);

  /// The override function from LocalizationsDelegate to reload the locale.
  @override
  bool shouldReload(LocalizationsDelegate<Translator> old) => true;
}
