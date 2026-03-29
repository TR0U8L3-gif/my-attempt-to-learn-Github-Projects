import 'rule.dart';

/// Rule 3: Password must contain at least one uppercase letter (A–Z).
class UppercaseRule extends Rule {
  @override
  String get description => 'Password must include an uppercase letter';

  @override
  bool validate(String password) => RegExp(r'[A-Z]').hasMatch(password);

  @override
  String errorMessage(String password) =>
      'Password must contain at least one uppercase letter (A–Z)';
}
