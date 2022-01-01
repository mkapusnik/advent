import 'dart:io';

Future<void> main() async {
  final File input = File('8/input.txt');
  final List<String> lines = await input.readAsLines();

  final List<String> numbers = [];
  for (final line in lines) {
    List<String> parts = line.split(' | ');
    numbers.addAll(parts[1].split(' '));
  }

  int result = numbers.where((element) => element.length == 2 || element.length == 4 || element.length == 3 || element.length == 7).length;

  print("Results: $result");
  //print("Lowest fuel: $lowest | Target: $target");
}