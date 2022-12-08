import 'dart:core';
import 'dart:io';

Future<void> main() async {
  final File input = File('5/input.txt');
  final List<String> lines = await input.readAsLines();

  final Map<int, List<String>> storage = createInitialStorage(lines.sublist(0, 8));
  storage.forEach((key, value) => print('$key: ${value.join(' ')}'));

  final RegExp regex = RegExp(r'^move ([0-9]+) from ([0-9]+) to ([0-9]+)$');
  for (int i = 10; i < lines.length; i++) {
    final RegExpMatch match = regex.firstMatch(lines[i])!;
    final int count = int.parse(match.group(1)!);
    final int origin = int.parse(match.group(2)!);
    final int target = int.parse(match.group(3)!);

    for(int i = 1; i <= count; i++) {
      final String crate = storage[origin]!.removeLast();
      storage[target]!.add(crate);
    }
  }

  print("-----------------------------");
  storage.forEach((key, value) => print('$key: ${value.join(' ')}'));
  print("-----------------------------");
  print("Top: ${storage.entries.fold('', (previousValue, element) => "$previousValue${element.value.last}")}");
}

Map<int, List<String>> createInitialStorage(List<String> lines) {
  Map<int, List<String>> storage = {};
  for(int column = 1; column < lines[lines.length-1].length; column += 4) {
    int index = (column + 3) ~/ 4;
    for(String line in lines) {
      final String crate = line[column].trim();
      if(crate.isNotEmpty) {
        if(!storage.containsKey(index)) storage[index] = [];
        storage[index]?.insert(0, crate);
      }
    }
  }
  return storage;
}