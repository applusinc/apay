import 'package:flutter/material.dart';

class Letter {
  static bool compareText(String text1, String text2) {
    debugPrint('text1 $text1, text2 $text2');
    final convertedText1 = letterConverter(text1);
    final convertedText2 = letterConverter(text2);
    if (similarityRatio(convertedText1, convertedText2) > 0.5) {
      return true;
    } else {
      return false;
    }
  }

  static letterConverter(String text) {
    final Map<String, String> replacements = {
      'æ': 'a',
      'Á': 'A',
      'á': 'a',
      'À': 'A',
      'à': 'a',
      'Ă': 'A',
      'ă': 'a',
      'Ắ': 'A',
      'ắ': 'a',
      'Ằ': 'A',
      'ằ': 'a',
      'Ẵ': 'A',
      'ẵ': 'a',
      'Ẳ': 'A',
      'ẳ': 'a',
      'Â': 'A',
      'â': 'a',
      'Ấ': 'A',
      'ấ': 'a',
      'Ầ': 'A',
      'ầ': 'a',
      'Ẫ': 'A',
      'ẫ': 'a',
      'Ẩ': 'A',
      'ẩ': 'a',
      'Ǎ': 'A',
      'ǎ': 'a',
      'Å': 'A',
      'å': 'a',
      'Ǻ': 'A',
      'ǻ': 'a',
      'Ä': 'A',
      'ä': 'a',
      'Ǟ': 'A',
      'ǟ': 'a',
      'Ã': 'A',
      'ã': 'a',
      'Ȧ': 'A',
      'ȧ': 'a',
      'Ǡ': 'A',
      'ǡ': 'a',
      'Ą': 'A',
      'ą': 'a',
      'Ā': 'A',
      'ā': 'a',
      'Ả': 'A',
      'ả': 'a',
      'Ȁ': 'A',
      'ȁ': 'a',
      'Ȃ': 'A',
      'ȃ': 'a',
      'Ạ': 'A',
      'ạ': 'a',
      'Ặ': 'A',
      'ặ': 'a',
      'Ậ': 'A',
      'ậ': 'a',
      'Ḁ': 'A',
      'ḁ': 'a',
      'Ⱥ': 'A',
      'ⱥ': 'a',
      'ᶏ': 'a',
      'ɐ': 'a',
      '∀': 'a',
      'ç': 'c',
      'Ç': 'C',
      'ğ': 'g',
      'Ğ': 'G',
      'ı': 'i',
      'İ': 'i,',
      'i': 'i',
      'I': 'i',
      'ö': 'o',
      'Ö': 'O',
      'ş': 's',
      'Ş': 'S',
      'ü': 'u',
      'Ü': 'U',
      'í': 'i',
      'Í': 'i',
      'É': 'E',
      'é': 'e',
      'È': 'E',
      'è': 'e',
      'Ĕ': 'E',
      'ĕ': 'e',
      'Ê': 'E',
      'ê': 'e',
      'Ế': 'E',
      'ế': 'e',
      'Ề': 'E',
      'ề': 'e',
      'Ễ': 'E',
      'ễ': 'e',
      'Ể': 'E',
      'ể': 'e',
      'Ě': 'E',
      'ě': 'e',
      'Ë': 'E',
      'ë': 'e',
      'Ẽ': 'E',
      'ẽ': 'e',
      'Ė': 'E',
      'ė': 'e',
      'Ȩ': 'E',
      'ȩ': 'e',
      'Ḝ': 'E',
      'ḝ': 'e',
      'Ę': 'E',
      'ę': 'e',
      'Ē': 'E',
      'ē': 'e',
      'Ḗ': 'E',
      'ḗ': 'e',
      'Ḕ': 'E',
      'ḕ': 'e',
      'Ẻ': 'E',
      'ẻ': 'e',
      'Ȅ': 'E',
      'ȅ': 'e',
      'Ȇ': 'E',
      'ȇ': 'e',
      'Ẹ': 'E',
      'ẹ': 'e',
      'Ệ': 'E',
      'ệ': 'e',
      'Ḙ': 'E',
      'ḙ': 'e',
      'Ḛ': 'E',
      'ḛ': 'e',
      'Ɇ': 'E',
      'ɇ': 'e',
      'ᶒ': 'e',
      'ó': 'o',
      'Ó': 'O',
      'ú': 'u',
      'Ú': 'U',
      'ñ': 'n',
      'Ñ': 'N',
      'Ì': 'i',
      'ì': 'i',
      'Ĭ': 'i',
      'ĭ': 'i',
      'Î': 'i',
      'î': 'i',
      'Ǐ': 'i',
      'ǐ': 'i',
      'Ï': 'i',
      'ï': 'i',
      'Ḯ': 'i',
      'ḯ': 'i',
      'Ĩ': 'i',
      'ĩ': 'i',
      'Į': 'i',
      'į': 'i',
      'Ī': 'i',
      'ī': 'i',
      'Ỉ': 'i',
      'ỉ': 'i',
      'Ȉ': 'i',
      'ȉ': 'i',
      'Ȋ': 'i',
      'ȋ': 'i',
      'Ị': 'i',
      'ị': 'i',
      'Ḭ': 'i',
      'ḭ': 'i',
      'Ɨ': 'i',
      'ɨ': 'i',
      'ᵻ': 'i',
      'ᶖ': 'i',
      'Ǽ': 'AE',
      'ǽ': 'ae',
      'Ć': 'C',
      'ć': 'c',
      'Ǵ': 'G',
      'ǵ': 'g',
      'Ḱ': 'K',
      'ḱ': 'k',
      'Ĺ': 'L',
      'ĺ': 'l',
      'Ḿ': 'M',
      'ḿ': 'm',
      'Ń': 'N',
      'ń': 'n',
      'Ǿ': 'O',
      'ǿ': 'o',
      'Ṕ': 'P',
      'ṕ': 'p',
      'Ŕ': 'R',
      'ŕ': 'r',
      'Ś': 'S',
      'ś': 's',
      'Ẃ': 'W',
      'ẃ': 'w',
      'Ý': 'Y',
      'ý': 'y',
      'Ź': 'Z',
      'ź': 'z',
    };

    for (var entry in replacements.entries) {
      text = text.replaceAll(entry.key, entry.value);
    }

    return text.toLowerCase();
  }

  static int levenshteinDistance(String s1, String s2) {
    var matrix = List.generate(s1.length + 1,
        (int row) => List.generate(s2.length + 1, (int col) => 0));

    for (var i = 0; i <= s1.length; i++) {
      for (var j = 0; j <= s2.length; j++) {
        if (i == 0) {
          matrix[i][j] = j;
        } else if (j == 0) {
          matrix[i][j] = i;
        } else {
          matrix[i][j] = [
            matrix[i - 1][j - 1] + (s1[i - 1] == s2[j - 1] ? 0 : 1),
            matrix[i][j - 1] + 1,
            matrix[i - 1][j] + 1
          ].reduce((value, element) => value > element ? element : value);
        }
      }
    }

    return matrix[s1.length][s2.length];
  }

  static double similarityRatio(String s1, String s2) {
    int maxLength = s1.length > s2.length ? s1.length : s2.length;
    int distance = levenshteinDistance(s1, s2);

    return 1 - distance / maxLength;
  }
}
