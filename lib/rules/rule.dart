/// Abstract base class for all password rules.
abstract class Rule {
  /// A human-readable description of what this rule requires.
  String get description;

  /// Returns true if [password] satisfies this rule.
  bool validate(String password);

  /// Returns a descriptive error message when [password] fails this rule.
  String errorMessage(String password);
}
