import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:free_google_translator/translate_model.dart';
import 'package:free_google_translator/utils/generate_token.dart';

class GoogleTranslator {
  static Future<List> translate({
    required TranslatorModel translatorModel,
  }) async {
    List translatedData = await compute(getTranslatedWord, translatorModel);
    return translatedData;
  }

  static String encodeMap(Map<String, List<String>> map) {
    return map.entries
        .map((entry) => entry.value
            .map((value) => '${entry.key}=${Uri.encodeComponent(value)}'))
        .expand((i) => i)
        .join('&');
  }

  static Future<List> getTranslatedWord(
    TranslatorModel translatorModel,
  ) async {
    String generatedToken = await TokenGeneration().getFinalToken(
      wordsToTranslate: translatorModel.wordsToTranslate,
    );

    var headers = {
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    };

    var uri = Uri.parse(
      'https://translate.googleapis.com/translate_a/t?client=te&v=1.0&sl=en&tl=${translatorModel.getLanguageString}&tk=$generatedToken',
    );

    var client = HttpClient();

    var request = await client.postUrl(uri);
    headers.forEach((key, value) {
      request.headers.set(key, value);
    });

    Map<String, List<String>> queryParams = {
      "q": translatorModel.wordsToTranslate,
    };
    var requestBody = encodeMap(queryParams);
    request.write(requestBody);

    var response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      String finalResponse =
          await response.transform(const Utf8Decoder()).join();
      return await json.decode(finalResponse);
    } else {
      debugPrint('Error: ${response.reasonPhrase}');
      return translatorModel.wordsToTranslate; // or throw an exception
    }
  }
}
