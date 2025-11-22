import 'dart:io';

class UserValidators {

  static bool isValidPassword(String password) {
    return password.length >= 8;
  }

  

static String customValidator(RegExp pattern, String errorMessage, String messageEntree) {
  String input;

  do {
    stdout.write('$messageEntree: ');
    input = stdin.readLineSync() ?? '';

    if (pattern.hasMatch(input)) {
      return input;
    } else {
      print(errorMessage);
    }
  } while (true);
}


}