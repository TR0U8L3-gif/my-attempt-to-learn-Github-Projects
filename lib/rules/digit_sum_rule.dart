import 'rule.dart';

/// Rule 5: The digits in the password must sum to exactly [targetSum].
class DigitSumRule extends Rule {
  final int targetSum;

  DigitSumRule({this.targetSum = 25});

  /// Calculates the sum of all digit characters in [password].
  int _digitSum(String password) {
    int sum = 0;
    for (final char in password.split('')) {
      final digit = int.tryParse(char);
      if (digit != null) sum += digit;
    }
    return sum;
  }

  @override
  String get description => 'Digits in password must sum to $targetSum';

  @override
  bool validate(String password) => _digitSum(password) == targetSum;

  @override
  String errorMessage(String password) {
    final sum = _digitSum(password);
    return 'Digits sum to $sum, but must sum to $targetSum';
  }
}
