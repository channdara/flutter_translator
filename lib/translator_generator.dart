import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translator/translator.dart';
import 'package:flutter_translator/translator_delegate.dart';

/// Callback for the translation. This will call after the translate()
/// function is called.
typedef TranslatorCallback = void Function(Locale);

class TranslatorGenerator {
  TranslatorGenerator._singleton() {
    _delegate = TranslatorDelegate(null);
  }

  static final TranslatorGenerator instance = TranslatorGenerator._singleton();

  TranslatorDelegate _delegate;
  List<String> languageCodes = const [];
  TranslatorCallback onTranslatedLanguage;

  /// Initialize the supported language and init language code when the app is
  /// start up. Both field will required.
  ///
  /// languageCodes use for checking the supported language code in the app
  /// and return the supportedLocales for the MaterialApp
  ///
  /// initLanguageCode mostly passed from the shared_preferences for checking
  /// the init language to display when the app is start up.
  void init({
    @required List<String> languageCodes,
    @required String initLanguageCode,
  }) {
    this.languageCodes = languageCodes;
    this._delegate = TranslatorDelegate(Locale(initLanguageCode ?? 'en'));
  }

  /// Call this function at where you want to translate the app like by
  /// pressing the button or any actions.
  void translate(String languageCode) {
    _delegate = TranslatorDelegate(Locale(languageCode));
    onTranslatedLanguage(Locale(languageCode));
  }

  /// This just call the getString from Translator class for getting the
  /// translated value from json file.
  String getString(BuildContext context, String key) =>
      Translator.of(context).getString(key);

  /// Generate the supported locales for the app.
  /// This will use at the MaterialAap
  Iterable<Locale> get supportedLocales =>
      languageCodes.map<Locale>((language) => Locale(language));

  /// Apply all the needed delegate and the package delegate for the app.
  /// This will use at the MaterialApp
  Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        _delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];
}
