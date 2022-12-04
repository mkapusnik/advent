import 'dart:io';

Future<void> main() async {
  final File input = File('1/input.txt');
  final List<String> lines = await input.readAsLines();

  int calories = 0;
  List<int> storage = [];
  for (final line in lines) {
    if(line.isEmpty) {
      storage.add(calories);
      calories = 0;
      continue;
    }

    int current = int.tryParse(line) ?? 0;
    calories += current;
  }
  storage.add(calories);
  storage.sort();

  var max = storage.last;
  print("Largest sum of calories: $max");
}