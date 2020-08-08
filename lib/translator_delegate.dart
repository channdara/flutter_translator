import 'package:flutter/material.dart';
import 'package:flutter_translator/translator.dart';
import 'package:flutter_translator/translator_generator.dart';

class TranslatorDelegate extends LocalizationsDelegate<Translator> {
  TranslatorDelegate(this.newLocale);

  final Locale newLocale;

  @override
  bool isSupported(Locale locale) =>
      TranslatorGenerator.instance.languageCodes.contains(locale.languageCode);

  @override
  Future<Translator> load(Locale locale) =>
      Translator.load(newLocale ?? locale);

  @override
  bool shouldReload(LocalizationsDelegate<Translator> old) => true;
}
