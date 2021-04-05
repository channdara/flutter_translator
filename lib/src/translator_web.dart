import 'dart:async';
import 'dart:html' as html show window;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// A web implementation of the FlutterTranslator plugin.
class FlutterTranslatorWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'flutter_translator',
      const StandardMethodCodec(),
      registrar,
    );
    channel.setMethodCallHandler(_handleMethodCall);
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getPlatformVersion':
        return html.window.navigator.userAgent;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'flutter_translator for web doesn\'t implement \'${call.method}\'',
        );
    }
  }
}
