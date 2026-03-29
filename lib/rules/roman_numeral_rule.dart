import 'rule.dart';

/// Rule 7: Password must contain at least one Roman numeral character
/// (I, V, X, L, C, D, or M).
class RomanNumeralRule extends Rule {
  static final _pattern = RegExp(r'[IVXLCDM]');

  @override
  String get description =>
      'Password must include a Roman numeral (I, V, X, L, C, D, M)';

  @override
  bool validate(String password) => _pattern.hasMatch(password);

  @override
  String errorMessage(String password) =>
      'Password must contain at least one Roman numeral character '
      '(I, V, X, L, C, D, or M)';
}
