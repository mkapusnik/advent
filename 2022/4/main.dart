import 'dart:core';
import 'dart:io';

Future<void> main() async {
  final File input = File('4/input.txt');
  final List<String> lines = await input.readAsLines();

  int overlaps = 0;
  for (String line in lines) {
    final List<String> elves = line.split(',');
    final List<int> first = assignedSections(elves[0]);
    final List<int> second = assignedSections(elves[1]);

    if(first.any((element) => second.contains(element)))
      overlaps++;
    else if(second.any((element) => first.contains(element)))
      overlaps++;
  }

  print("-----------------------------");
  print("Total overlaps: $overlaps");
}

List<int> assignedSections(String input) {
  final List<String> range = input.split('-');
  int start = int.parse(range[0]);
  int end = int.parse(range[1]);

  return List.generate(end - start + 1, (index) => start + index);
}