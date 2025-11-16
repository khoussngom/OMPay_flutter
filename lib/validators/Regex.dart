class Regex {
  static final RegExp email = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp senegalPhoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
  static final RegExp isValidSenegalCNI = RegExp(r'^[A-Z0-9]{5,20}$');
}