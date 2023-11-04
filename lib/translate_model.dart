import 'package:free_google_translator/extensions/language_model_extension.dart';
import 'package:free_google_translator/languages.dart';

class TranslatorModel {
  List<String> wordsToTranslate;
  Languages languageToConvert;
  TranslatorModel({
    this.wordsToTranslate = const [],
    this.languageToConvert = Languages.en,
  });
  String? get getLanguageString {
    return languageToConvert.getLanguageFullName;
  }
}
