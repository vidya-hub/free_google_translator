import 'package:flutter/material.dart';
import 'package:free_google_translator/languages.dart';

class LanguageNotifier extends ValueNotifier<Languages> {
  LanguageNotifier(Languages value) : super(value);

  void changeLanguage(Languages newLanguage) {
    if (value != newLanguage) {
      value = newLanguage;
    }
  }
}
