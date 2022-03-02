import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translator/src/language_name.dart';
import 'package:flutter_translator/flutter_translator.dart';

class Translator {
  Translator._singleton();

  static final Translator instance = Translator._singleton();

  static Map<String, dynamic> _string = {};
  static bool _isInitWithMap = false;
  static List<MapLocale> _mapLocales = [];

  static Translator? of(BuildContext context) =>
      Localizations.of<Translator>(context, Translator);

  set initStatus(bool status) => _isInitWithMap = status;

  set mapLocales(List<MapLocale> mapLocales) => _mapLocales = mapLocales;

  /// This function will load the json data from the specific location and
  /// file name and tag provided by the locale language code.
  ///
  /// Make sure the path of the json file which will use for translation
  /// is at the root project << assets/locales/ >> and the file name must be
  /// localization_{languageCode}.json. example: localization_en.json
  static Future<Translator> load(Locale locale) async {
    if (_isInitWithMap) {
      _string = _mapLocales
          .where((e) => e.languageCode == locale.languageCode)
          .first
          .mapData;
    } else {
      final path = 'assets/locales/localization_${locale.languageCode}.json';
      final jsonContent = await rootBundle.loadString(path);
      _string = json.decode(jsonContent);
    }
    return instance;
  }

  /// This function will return the value of the json file which loaded by the
  /// load function above.
  String getString(String key) =>
      _string[key] == null ? '$key not found' : _string[key].toString();

  /// This function will return the language name by the language code provided.
  String getName(String languageCode) => languageName[languageCode] == null
      ? 'Name for $languageCode not found'
      : languageName[languageCode].toString();
}
