import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Translator {
  Translator._singleton();

  static final Translator _instance = Translator._singleton();

  static Map<String, dynamic> _map;

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
    _map = json.decode(jsonContent) as Map<String, dynamic>;
    return _instance;
  }

  /// This function will return the value of the json file which loaded by the
  /// load function above.
  String getString(String key) =>
      _map[key] == null ? '$key not found' : _map[key].toString();
}
