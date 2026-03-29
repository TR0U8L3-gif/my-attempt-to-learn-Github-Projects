import 'rule.dart';

/// Rule 1: Password must be at least [minLength] characters long.
class MinLengthRule extends Rule {
  final int minLength;

  MinLengthRule({this.minLength = 5});

  @override
  String get description => 'Password must be at least $minLength characters';

  @override
  bool validate(String password) => password.length >= minLength;

  @override
  String errorMessage(String password) =>
      'Password is too short (${password.length}/$minLength characters)';
}
