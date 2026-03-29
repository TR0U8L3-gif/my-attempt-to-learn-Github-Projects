import 'rule.dart';

/// Rule 6: Password must contain the name of a month (January–December).
///
/// The match is case-insensitive, so "JANUARY", "january", and "January"
/// all satisfy the rule.
class MonthRule extends Rule {
  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  String get description =>
      'Password must include a month name (January–December)';

  @override
  bool validate(String password) {
    final lower = password.toLowerCase();
    return _months.any((month) => lower.contains(month.toLowerCase()));
  }

  @override
  String errorMessage(String password) =>
      'Password must contain a month name '
      '(January, February, ..., December)';
}
