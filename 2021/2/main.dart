import 'dart:io';

Future<void> main() async {
  final File input = File('input.txt');
  final List<String> lines = await input.readAsLines();

  int position = 0, depth = 0;
  for (final line in lines) {
    final List<String> instruction = line.split(' ');
    final int speed = int.tryParse(instruction[1]) ?? 0;
    switch(instruction[0]) {
      case 'forward': position += speed; break;
      case 'up': depth -= speed; break;
      case 'down': depth += speed; break;
      default: throw "Invalid instruction: ${instruction[0]}";
    }
  }
  print("Position: $position, Depth: $depth, Distance: ${position * depth}");
}