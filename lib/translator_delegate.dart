import 'package:flutter/material.dart';
import 'package:flutter_translator/translator.dart';
import 'package:flutter_translator/translator_generator.dart';

/// This is just the delegate class of the Translator. It's required locale
/// provide to the Translator class for load the json file.
class TranslatorDelegate extends LocalizationsDelegate<Translator> {
  TranslatorDelegate(this.newLocale);

  final Locale newLocale;

  /// The override function from LocalizationsDelegate to check the supported
  /// language provided by the app configuration
  @override
  bool isSupported(Locale locale) =>
      TranslatorGenerator.instance.languageCodes.contains(locale.languageCode);

  /// The override function from LocalizationsDelegate to load the locale
  @override
  Future<Translator> load(Locale locale) =>
      Translator.load(newLocale ?? locale);

  /// The override function from LocalizationsDelegate to reload the locale.
  @override
  bool shouldReload(LocalizationsDelegate<Translator> old) => true;
}
