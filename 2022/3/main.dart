import 'dart:io';

Future<void> main() async {
  final File input = File('3/input.txt');
  final List<String> lines = await input.readAsLines();

  int priorities = 0;
  for (final line in lines) {
    print('Rucksack: $line');
    final String first = line.substring(0, line.length ~/ 2);
    final String second = line.substring(line.length ~/ 2);
    print('1:$first');
    print('2:$second');
    int common = findCommonLetters(first, second);
    print('Common priority: $common');
    priorities += common;
    print("-----------------------------");
  }

  print("-----------------------------");
  print("Total priorities: $priorities");
}

int findCommonLetters(String first, String second) {
  first.split('').forEach((element) {
    if(second.contains(element)) {
      print('Common letter: $element');
    }
  });

  return getPriority(first.split('').firstWhere((element) => second.contains(element)));
}

int getPriority(String letter) {
  int code = letter.codeUnitAt(0) - 96;
  if(code < 0) code += 31 + 27;
  return code;
}