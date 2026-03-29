import 'rule.dart';

/// Rule 2: Password must contain at least one digit (0–9).
class NumberRule extends Rule {
  @override
  String get description => 'Password must include a number';

  @override
  bool validate(String password) => RegExp(r'\d').hasMatch(password);

  @override
  String errorMessage(String password) =>
      'Password must contain at least one number (0–9)';
}
