import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Translator {
  Translator._singleton();

  static final Translator instance = Translator._singleton();

  static Map<String, dynamic> _string;
  static Map<String, dynamic> _name;

  static Translator of(BuildContext context) =>
      Localizations.of<Translator>(context, Translator);

  /// This function will load the json data from the specific location and
  /// file name and tag provided by the locale language code.
  ///
  /// Make sure the path of the json file which will use for translation
  /// is at the root project << assets/locales/ >> and the file name must be
  /// localization_{languageCode}.json. example: localization_en.json
  static Future<Translator> load(Locale locale) async {
    final path = 'assets/locales/localization_${locale.languageCode}.json';
    final jsonContent = await rootBundle.loadString(path);
    _string = json.decode(jsonContent) as Map<String, dynamic>;
    return instance;
  }

  /// This function will load the language name from the json file. This might
  /// not be 100% accurate by you can help by reporting the incorrect language
  /// name in our repository.
  Future<void> loadLanguageName() async {
    final path = 'packages/flutter_translator/language_name.json';
    final jsonContent = await rootBundle.loadString(path);
    _name = json.decode(jsonContent) as Map<String, dynamic>;
  }

  /// This function will return the value of the json file which loaded by the
  /// load function above.
  String getString(String key) =>
      _string[key] == null ? '$key not found' : _string[key].toString();

  /// This function will return the language name by the language code provided.
  String getName(String languageCode) => _name[languageCode] == null
      ? 'Name for $languageCode not found'
      : _name[languageCode].toString();
}
