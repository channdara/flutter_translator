import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translator/src/map_locale.dart';
import 'package:flutter_translator/src/translator.dart';
import 'package:flutter_translator/src/translator_delegate.dart';
import 'package:flutter_translator/src/translator_util.dart';

typedef TranslatorCallback = void Function(Locale?);

class TranslatorGenerator {
  TranslatorGenerator._singleton() {
    _delegate = TranslatorDelegate(null);
  }

  /// The instance object of TranslatorGenerator class.
  static final TranslatorGenerator instance = TranslatorGenerator._singleton();

  /// The package delegate. This is private, only use in the package.
  TranslatorDelegate? _delegate;

  /// The list of supported language code provide by the [init] function
  List<String> _supportedLanguageCodes = const [];

  /// The current locale of the app. It will change after [translate] called.
  Locale? _currentLocale;

  /// Callback for the translation. This will call after the [translate]
  /// function is called.
  TranslatorCallback? onTranslatedLanguage;

  /// Initialize the list of mapLocale (see [MapLocale] model for info)
  /// and initLanguageCode code when the app is start up. Both field will required.
  ///
  /// initLanguageCode mostly passed from the shared_preferences for checking
  /// the init language to display when the app is start up.
  Future<void> init({
    required List<MapLocale> mapLocales,
    required String initLanguageCode,
    String? initCountryCode,
  }) async {
    Translator.instance.mapLocales = mapLocales;
    _supportedLanguageCodes = mapLocales.map((e) => e.languageCode).toList();
    await _handleLocale(initLanguageCode, initCountryCode);
  }

  /// This will handle the locale of the app. Load the saved locale and init new
  /// delegate for the app localization.
  Future<void> _handleLocale(
    String initLanguageCode,
    String? initCountryCode,
  ) async {
    _currentLocale = Locale(initLanguageCode, initCountryCode);
    _currentLocale = await TranslatorUtil.getInitLocale(
      initLanguageCode,
      initCountryCode,
    );
    _delegate = TranslatorDelegate(_currentLocale);
    if (onTranslatedLanguage != null) onTranslatedLanguage!(_currentLocale);
  }

  /// Call this function at where you want to translate the app like by
  /// pressing the button or any actions.
  void translate(
    String languageCode, {
    String countryCode = '',
    bool save = true,
  }) {
    if (languageCode == _currentLocale?.languageCode) return;
    if (save) TranslatorUtil.setLocale(languageCode, countryCode);
    _currentLocale = Locale(languageCode, countryCode);
    _delegate = TranslatorDelegate(_currentLocale);
    if (onTranslatedLanguage != null) onTranslatedLanguage!(_currentLocale);
  }

  /// This just call the getString() function from [Translator] class for getting
  /// the translated value from map data.
  String getString(String key) => Translator.instance.getString(key);

  /// This just call the getName() function from [Translator] class for getting
  /// the full language name by the language code.
  String getLanguageName({String? languageCode}) =>
      Translator.instance.getName(languageCode ?? _currentLocale!.languageCode);

  /// Get the list of supported language code provide by the [init] function
  List<String> get supportedLanguageCodes => _supportedLanguageCodes;

  /// Get the current locale of the app.
  Locale? get currentLocale => _currentLocale;

  /// Generate the supported locales for the app.
  /// This will use at the MaterialAap
  Iterable<Locale> get supportedLocales =>
      _supportedLanguageCodes.map<Locale>((language) => Locale(language));

  /// Apply all the needed delegate and the package delegate for the app.
  /// This will use at the MaterialApp
  Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        _delegate!,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];
}
