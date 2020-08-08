extension StringExtensions on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[*.!@$%^&(){}[]:;<>,.?/~_+-=|\]).{8,32}$");
    return passwordRegExp.hasMatch(this);
  }

  String get pascalCase {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String get captialCamelCase {
    String capitalize(Match m) =>
        m[0].substring(0, 1).toUpperCase() + m[0].substring(1);
    String skip(String s) => "";
    return this
        .splitMapJoin(RegExp(r'[a-z]+'), onMatch: capitalize, onNonMatch: skip);
  }
}
