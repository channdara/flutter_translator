import 'package:flutter_translator/flutter_translator.dart';

extension StringExtension on String {
  String getString() => TranslatorGenerator.instance.getString(this);
}
