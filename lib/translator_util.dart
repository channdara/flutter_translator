import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin TranslatorUtil {
  static const String _locale_key = 'locale_key';
  static const String _language_code = 'language_code';
  static const String _country_code = 'country_code';

  static Future<Locale> getLocale() async {
    final pref = await SharedPreferences.getInstance();
    final prefData = pref.getString(_locale_key);
    if (prefData == null) return Locale('en', 'US');
    final locale = json.decode(prefData);
    return Locale(locale[_language_code], locale[_country_code]);
  }

  static Future<bool> setLocale(String languageCode, String countryCode) async {
    final pref = await SharedPreferences.getInstance();
    final value = json.encode({
      _language_code: languageCode,
      _country_code: countryCode,
    });
    return await pref.setString(_locale_key, value);
  }

  static Future<Locale> getInitLocale(String lInit, String cInit) async {
    return await getLocale() ?? Locale(lInit ?? 'en', cInit ?? 'US');
  }
}
