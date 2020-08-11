import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translator/translator.dart';
import 'package:flutter_translator/translator_delegate.dart';
import 'package:flutter_translator/translator_util.dart';

/// Callback for the translation. This will call after the translate()
/// function is called.
typedef TranslatorCallback = void Function(Locale);

class TranslatorGenerator {
  TranslatorGenerator._singleton() {
    _delegate = TranslatorDelegate(null);
  }

  /// The instance object of TranslatorGenerator class.
  static final TranslatorGenerator instance = TranslatorGenerator._singleton();

  /// The package delegate. This is private, only use in the package.
  TranslatorDelegate _delegate;

  /// The list of supported language code provide by the init() function
  List<String> _languageCodes = const [];

  /// Translator callback after translate() called
  TranslatorCallback onTranslatedLanguage;

  /// The current locale of the app. It will change after translate() called.
  Locale _currentLocale;

  /// Initialize the supported language and init language code when the app is
  /// start up. Both field will required.
  ///
  /// languageCodes use for checking the supported language code in the app
  /// and return the supportedLocales for the MaterialApp
  ///
  /// initLanguageCode mostly passed from the shared_preferences for checking
  /// the init language to display when the app is start up.
  Future<void> init({
    @required List<String> languageCodes,
    @required String initLanguageCode,
    String initCountryCode,
  }) async {
    this._languageCodes = languageCodes;
    this._currentLocale = await TranslatorUtil.getInitLocale(
      initLanguageCode,
      initCountryCode,
    );
    this._delegate = TranslatorDelegate(_currentLocale);
  }

  /// Call this function at where you want to translate the app like by
  /// pressing the button or any actions.
  void translate(String languageCode, [String countryCode = '']) {
    TranslatorUtil.setLocale(languageCode, countryCode);
    this._currentLocale = Locale(languageCode, countryCode);
    this._delegate = TranslatorDelegate(_currentLocale);
    this.onTranslatedLanguage(_currentLocale);
  }

  /// This just call the getString from Translator class for getting the
  /// translated value from json file.
  String getString(BuildContext context, String key) =>
      Translator.of(context).getString(key);

  /// Get the list of supported language code provide by the init() function
  List<String> get languageCodes => this._languageCodes;

  /// Get the current locale of the app.
  Locale get currentLocale => this._currentLocale;

  /// Generate the supported locales for the app.
  /// This will use at the MaterialAap
  Iterable<Locale> get supportedLocales =>
      _languageCodes.map<Locale>((language) => Locale(language));

  /// Apply all the needed delegate and the package delegate for the app.
  /// This will use at the MaterialApp
  Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        _delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];
}
