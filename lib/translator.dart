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

  static Future<Translator> load(Locale locale) async {
    final path = 'assets/locales/localization_${locale.languageCode}.json';
    final jsonContent = await rootBundle.loadString(path);
    _map = json.decode(jsonContent) as Map<String, dynamic>;
    return _instance;
  }

  String getString(String key) =>
      _map[key] == null ? '$key not found' : _map[key].toString();
}
