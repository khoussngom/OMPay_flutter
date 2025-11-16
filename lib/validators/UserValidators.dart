import 'dart:io';

class UserValidators {

  static bool isValidPassword(String password) {
    return password.length >= 8;
  }

  static String controleSaisie(String input) {
    while (input.trim().isEmpty) {
      stdout.write('Entrée invalide. Veuillez réessayer: ');
      input = stdin.readLineSync() ?? '';
    }
    return input.trim();
  }


  static String verifierPassword() {
    String password;
    String confirmPassword;

    while (true) {
      stdout.write('Entrez le mot de passe: ');
      password = controleSaisie(stdin.readLineSync() ?? '');


      stdout.write('Confirmez le mot de passe: ');
      confirmPassword = controleSaisie(stdin.readLineSync() ?? '');

      if (password != confirmPassword) {
        print('Les mots de passe ne correspondent pas. Veuillez réessayer.');
        continue;
      }

      if (!isValidPassword(password)) {
        print('Le mot de passe doit contenir au moins 8 caractères.');
        continue;
      }

      break;
    }

    return password;
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