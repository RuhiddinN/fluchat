import 'dart:math';

class Token {
  static String now() => DateTime.now().toString();
  static String symbols =
      "qwertyuiopasdfghjklzxcvbnm123456789QWERTYUIOPASDFGHJKLZXCVBNM_";

  static String id() {
    String string = '';
    for (int i = 0; i < 32; i++) {
      Random random = Random();
      string += symbols[random.nextInt(symbols.length)];
    }

    return string;
  }
}
