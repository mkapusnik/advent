import 'dart:core';
import 'dart:io';

Future<void> main() async {
  final File input = File('6/input.txt');
  final List<String> lines = await input.readAsLines();

  int position = findMarker(lines[0]);
  lines[0][position];
  print("Marker position: $position");
}

int findMarker(String line) {
  for (int i = 3; i < line.length; i++) {
    Set<String> buffer = {};
    buffer.add(line[i]);
    buffer.add(line[i-1]);
    buffer.add(line[i-2]);
    buffer.add(line[i-3]);
    if(buffer.length > 3) {
      print("Buffer: ${buffer.join(' | ')}");
      return i+1;
    }
  }
  return 0;
}