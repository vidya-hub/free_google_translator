import 'package:flutter/foundation.dart';

class TokenGeneration {
  List<int> oo(String a) {
    List<int> b = [];
    int c = 0;
    int d = 0;

    for (int i = 0; i < a.length; i++) {
      int e = a.codeUnitAt(i);
      if (e < 128) {
        b.add(e);
        c++;
      } else if (e < 2048) {
        b.add((e >> 6) | 192);
        b.add((e & 63) | 128);
        c += 2;
      } else {
        if (55296 == (e & 64512) &&
            i + 1 < a.length &&
            56320 == (a.codeUnitAt(i + 1) & 64512)) {
          e = 65536 + ((e & 1023) << 10) + (a.codeUnitAt(++i) & 1023);
          b.add((e >> 18) | 240);
          b.add(((e >> 12) & 63) | 128);
          b.add(((e >> 6) & 63) | 128);
          b.add((e & 63) | 128);
          c += 4;
        } else {
          b.add((e >> 12) | 224);
          b.add(((e >> 6) & 63) | 128);
          b.add((e & 63) | 128);
          c += 3;
        }
      }
    }

    return b;
  }

  int jq(int a, String b) {
    for (int c = 0; c < b.length - 2; c += 3) {
      int d = b.codeUnitAt(c + 2);

      d = (d >= 97) ? d - 87 : int.parse(String.fromCharCode(d));
      d = (b[c + 1] == "+") ? (a >> d) : (a << d);
      a = (b[c] == "+") ? (a + d) & 4294967295 : (a ^ d);
    }
    return a;
  }

  String lq(String a) {
    List<String> b = ["471414", "523112976"];
    int c = int.tryParse(b[0]) ?? 0;
    List<int> aEncoded = oo(a);
    int d = c;
    for (int e = 0; e < aEncoded.length; e++) {
      d += aEncoded[e];
      d = jq(d, "+-a^+6");
    }

    d = jq(d, "+-3^+b+-f");
    d ^= int.tryParse(b[1]) ?? 0;
    if (d < 0) {
      d = (d & 2147483647) + 2147483648;
    }

    int result = d % 1000000;
    return "$result.${result ^ c}";
  }

  Future<String> getFinalToken(
      {List<String> wordsToTranslate = const []}) async {
    String translatedWords = wordsToTranslate.join("");
    String finalToken = await compute(lq, translatedWords);
    return finalToken;
  }
}
