import 'dart:io';

import 'package:password_game/game_engine.dart';
import 'package:password_game/rules/min_length_rule.dart';
import 'package:password_game/rules/number_rule.dart';
import 'package:password_game/rules/uppercase_rule.dart';
import 'package:password_game/rules/special_character_rule.dart';
import 'package:password_game/rules/digit_sum_rule.dart';
import 'package:password_game/rules/month_rule.dart';
import 'package:password_game/rules/roman_numeral_rule.dart';

// ANSI color codes
const _reset = '\x1B[0m';
const _green = '\x1B[32m';
const _yellow = '\x1B[33m';
const _cyan = '\x1B[36m';
const _bold = '\x1B[1m';

void main() {
  // Build the ordered list of rules
  final engine = GameEngine(
    rules: [
      MinLengthRule(),          // Rule 1
      NumberRule(),             // Rule 2
      UppercaseRule(),          // Rule 3
      SpecialCharacterRule(),   // Rule 4
      DigitSumRule(),           // Rule 5
      MonthRule(),              // Rule 6
      RomanNumeralRule(),       // Rule 7
    ],
  );

  print('');
  print('$_cyan$_bold╔══════════════════════════════════════╗');
  print('║           PASSWORD GAME              ║');
  print('║  Can you satisfy all the rules?      ║');
  print('╚══════════════════════════════════════╝$_reset');
  print('');
  print('Rules unlock one by one as you satisfy them.');
  print('Type ${_bold}quit$_reset to exit the game at any time.');

  // Main game loop
  while (!engine.isComplete) {
    engine.printStatus();

    stdout.write('Enter password: ');
    final input = stdin.readLineSync() ?? '';

    if (input.trim().toLowerCase() == 'quit') {
      print('');
      print('Goodbye! Thanks for playing. 👋');
      print('');
      return;
    }

    final passed = engine.validateAndProgress(input);

    if (!passed) {
      print('');
      print('Try again! Keep the requirements above in mind.');
    }
  }

  // Player has passed all rules
  print('');
  print('$_yellow$_bold╔══════════════════════════════════════╗');
  print('║   🎉  YOU WIN! ALL RULES PASSED!  🎉  ║');
  print('╚══════════════════════════════════════╝$_reset');
  print('');
  print('$_green${_bold}Congratulations! You are a password master! 🏆$_reset');
  print('');
}
