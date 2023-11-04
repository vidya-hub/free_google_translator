import 'package:free_google_translator/languages.dart';

extension LanguageModelExtension on Languages {
  String get enumToString {
    return this == Languages.ice ? "is" : toString().split('.').last;
  }

  get getLanguageFullName {
    return LanguageUtils.LANGUAGES[(enumToString)] ?? "English";
  }
}

extension LanguageStringExtension on String {
  Languages stringToEnum(String value) {
    try {
      return Languages.values.firstWhere((language) {
        return language.enumToString == value;
      });
    } catch (e) {
      return Languages.en;
    }
  }
}
