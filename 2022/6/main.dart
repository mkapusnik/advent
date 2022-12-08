import 'dart:core';
import 'dart:io';

Future<void> main() async {
  final File input = File('6/input.txt');
  final List<String> lines = await input.readAsLines();

  int position = findMarker(lines[0]);
  lines[0][position];
  print("Marker position: $position");
}
const int markerLength = 14;
int findMarker(String line) {
  for (int i = markerLength-1; i < line.length; i++) {
    Set<String> buffer = {};
    for(int l = 0; l < markerLength; l++) {
      buffer.add(line[i - l]);
    }
    if(buffer.length >= markerLength) {
      print("Buffer: ${buffer.join(' | ')}");
      return i+1;
    }
  }
  return 0;
}