import 'dart:io';

Future<void> main() async {
  final File input = File('2/input.txt');
  final List<String> lines = await input.readAsLines();

  int position = 0, depth = 0, aim = 0;
  for (final line in lines) {
    final List<String> instruction = line.split(' ');
    final int arg = int.tryParse(instruction[1]) ?? 0;
    switch(instruction[0]) {
      case 'forward': position += arg; depth += (aim * arg); break;
      case 'up': aim -= arg; break;
      case 'down': aim += arg; break;
      default: throw "Invalid instruction: ${instruction[0]}";
    }
  }
  print("Position: $position, Depth: $depth, Distance: ${position * depth}");
}