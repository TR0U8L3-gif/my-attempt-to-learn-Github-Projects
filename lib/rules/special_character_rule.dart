import 'rule.dart';

/// Rule 4: Password must contain at least one special character.
class SpecialCharacterRule extends Rule {
  // Matches common special/punctuation characters
  static final _pattern = RegExp(r'[!@#$%^&*()\-_=+\[\]{};:",.<>?/\\|~]');

  @override
  String get description => 'Password must include a special character';

  @override
  bool validate(String password) => _pattern.hasMatch(password);

  @override
  String errorMessage(String password) =>
      r'Password must contain at least one special character (e.g. !@#$%^&*()-_=+[]{}|<>?,./\~)';
}
