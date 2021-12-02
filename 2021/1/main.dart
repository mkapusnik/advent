import 'dart:io';

Future<void> main() async {
  final File script = File('input.txt');
  final List<String> lines = await script.readAsLines();

  int increases = 0;
  int? previous;
  for (final line in lines) {
    int current = int.tryParse(line) ?? 0;
    if(previous != null && current > previous) {
      increases++;
    }
    previous = current;
  }
  print("Num of increases: $increases");
}