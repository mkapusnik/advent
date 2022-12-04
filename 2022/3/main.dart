import 'dart:io';

Future<void> main() async {
  final File input = File('3/input.txt');
  final List<String> lines = await input.readAsLines();

  int priorities = 0;
  for (int i = 0; i < lines.length; i += 3) {
    final String first = lines[i];
    final String second = lines[i+1];
    final String third = lines[i+2];
    print('1:$first');
    print('2:$second');
    print('3:$third');

    int common = findCommonLetters(first, second, third);
    print('Common priority: $common');
    priorities += common;
    print("-----------------------------");
  }

  print("-----------------------------");
  print("Total priorities: $priorities");
}

int findCommonLetters(String first, String second, String third) {
  final String letter = first
      .split('')
      .firstWhere((element) => second.contains(element) && third.contains(element));
  print('Common letter: $letter');
  return getPriority(letter);
}

int getPriority(String letter) {
  int code = letter.codeUnitAt(0) - 96;
  if(code < 0) code += 31 + 27;
  return code;
}