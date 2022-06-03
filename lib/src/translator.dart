import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_translator/flutter_translator.dart';
import 'package:flutter_translator/src/language_name.dart';

class Translator {
  Translator._singleton();

  static final Translator instance = Translator._singleton();

  static Map<String, dynamic> _string = {};
  static List<MapLocale> _mapLocales = [];

  set mapLocales(List<MapLocale> mapLocales) => _mapLocales = mapLocales;

  /// This function will load the value from the specific map data that provided
  /// by the [MapLocale] object from the initialization and return an instance
  /// of the [Translator] class as a Future.
  Future<Translator> load(Locale locale) async {
    _string = _mapLocales
        .where((e) => e.languageCode == locale.languageCode)
        .first
        .mapData;
    return instance;
  }

  /// This function will return the value of the map data which loaded by the
  /// [load] function above.
  String getString(String key) =>
      _string[key] == null ? '$key not found' : _string[key].toString();

  /// This function will return the language name by the language code provided.
  String getName(String languageCode) => languageName[languageCode] == null
      ? 'Name for $languageCode not found'
      : languageName[languageCode].toString();
}
