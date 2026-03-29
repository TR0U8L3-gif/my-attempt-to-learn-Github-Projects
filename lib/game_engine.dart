import 'rules/rule.dart';

// ANSI color codes for terminal output
const _reset = '\x1B[0m';
const _red = '\x1B[31m';
const _green = '\x1B[32m';
const _yellow = '\x1B[33m';
const _cyan = '\x1B[36m';
const _bold = '\x1B[1m';

/// Manages the game state: which rules are active and how to validate passwords.
class GameEngine {
  final List<Rule> rules;

  /// Number of rules currently unlocked (1-based). Starts at 1.
  int _unlockedCount = 1;

  GameEngine({required this.rules}) {
    if (rules.isEmpty) throw ArgumentError('At least one rule is required');
  }

  /// Index of the most recently unlocked rule (0-based).
  int get currentRuleIndex => _unlockedCount - 1;

  /// Total number of rules in the game.
  int get totalRules => rules.length;

  /// Returns true when the player has passed all rules.
  bool get isComplete => _unlockedCount > rules.length;

  /// The rules currently active (all unlocked rules).
  List<Rule> get activeRules => rules.sublist(0, _unlockedCount.clamp(0, rules.length));

  /// Prints current game status: progress bar and active rules.
  void printStatus() {
    print('');
    print('$_cyan$_bold╔══════════════════════════════════════╗$_reset');
    print('$_cyan$_bold║           PASSWORD GAME              ║$_reset');
    print('$_cyan$_bold╚══════════════════════════════════════╝$_reset');
    print('');

    final completed = _unlockedCount - 1;
    print('$_bold Progress: $completed/${rules.length} rules completed$_reset');
    _printProgressBar(completed, rules.length);
    print('');

    print('$_bold Active rules:$_reset');
    for (int i = 0; i < _unlockedCount && i < rules.length; i++) {
      print('  ${_cyan}Rule ${i + 1}:$_reset ${rules[i].description}');
    }
    print('');
  }

  /// Validates [password] against all active rules.
  ///
  /// Returns true if every active rule passes. When a rule fails, its error
  /// message is printed in red. When all rules pass, advances to the next rule
  /// and returns true.
  bool validateAndProgress(String password) {
    final errors = <String>[];

    for (int i = 0; i < _unlockedCount && i < rules.length; i++) {
      if (!rules[i].validate(password)) {
        errors.add('Rule ${i + 1}: ${rules[i].errorMessage(password)}');
      }
    }

    if (errors.isNotEmpty) {
      print('');
      for (final error in errors) {
        print('  $_red✗ $error$_reset');
      }
      return false;
    }

    // All active rules passed
    print('');
    print('  $_green✓ All active rules passed!$_reset');

    if (_unlockedCount < rules.length) {
      _unlockedCount++;
      print('  $_yellow🔓 New rule unlocked: Rule $_unlockedCount: ${rules[_unlockedCount - 1].description}$_reset');
    } else {
      // Last rule completed
      _unlockedCount++;
    }

    return true;
  }

  void _printProgressBar(int completed, int total) {
    const barWidth = 30;
    final filled = total == 0 ? 0 : (completed * barWidth ~/ total);
    final empty = barWidth - filled;
    final bar = '█' * filled + '░' * empty;
    print('  [$_green$bar$_reset] $completed/$total');
  }
}
